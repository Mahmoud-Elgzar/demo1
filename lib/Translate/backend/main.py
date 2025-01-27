from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from transformers import MarianMTModel, MarianTokenizer
import speech_recognition as sr
import pyttsx3
import sounddevice as sd
from scipy.io.wavfile import write
import tempfile
import os

# Initialize FastAPI app
app = FastAPI()

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for development; adjust for production
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods
    allow_headers=["*"],  # Allow all headers
)

# Initialize TTS engine for speaking the translated text
engine = pyttsx3.init()

# Supported languages dictionary
supported_languages = {
    "en": "English", "fr": "French", "es": "Spanish", "de": "German",
    "it": "Italian", "ru": "Russian", "zh": "Chinese", "ar": "Arabic",
    "hi": "Hindi", "ja": "Japanese", "ko": "Korean", "pt": "Portuguese",
    "nl": "Dutch", "sv": "Swedish", "pl": "Polish", "tr": "Turkish",
    "vi": "Vietnamese", "th": "Thai", "he": "Hebrew", "id": "Indonesian"
}

# Model for input data validation
class TranslationRequest(BaseModel):
    src_lang: str
    tgt_lang: str
    text: str

class SpeakRequest(BaseModel):
    text: str

def load_model(src_lang, tgt_lang):
    """Load the appropriate translation model."""
    model_name = f'Helsinki-NLP/opus-mt-{src_lang}-{tgt_lang}'
    try:
        tokenizer = MarianTokenizer.from_pretrained(model_name)
        model = MarianMTModel.from_pretrained(model_name)
        return model, tokenizer
    except Exception as e:
        print(f"Model loading error: {e}")  # Log error
        raise

def translate_text(text, model, tokenizer):
    """Translate input text."""
    inputs = tokenizer(text, return_tensors="pt", padding=True)
    translated = model.generate(**inputs)
    translated_text = tokenizer.decode(translated[0], skip_special_tokens=True)
    return translated_text

@app.post("/translate")
async def translate(request: TranslationRequest):
    """Translate text from source to target language."""
    if request.src_lang not in supported_languages or request.tgt_lang not in supported_languages:
        raise HTTPException(status_code=400, detail="Unsupported language.")
    
    try:
        print(f"Translating text: {request.text} from {request.src_lang} to {request.tgt_lang}")  # Debug info
        model, tokenizer = load_model(request.src_lang, request.tgt_lang)
        translated_text = translate_text(request.text, model, tokenizer)
        print(f"Translated text: {translated_text}")  # Debug info
        return {"translated_text": translated_text}
    except Exception as e:
        print(f"Error: {e}")  # Log error
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/recognize")
async def recognize(language: str = 'en'):
    """Capture speech and recognize it using sounddevice."""
    duration = 10  # Duration of recording in seconds
    samplerate = 16000  # Sample rate for recording

    try:
        print("Recording audio...")  # Debug info
        # Record audio using sounddevice
        recording = sd.rec(int(duration * samplerate), samplerate=samplerate, channels=1, dtype='int16')
        sd.wait()  # Wait until recording is finished

        # Save audio to a temporary file
        with tempfile.NamedTemporaryFile(delete=False, suffix=".wav") as temp_audio_file:
            write(temp_audio_file.name, samplerate, recording)
            temp_audio_path = temp_audio_file.name

        # Recognize speech using speech_recognition
        recognizer = sr.Recognizer()
        with sr.AudioFile(temp_audio_path) as source:
            audio = recognizer.record(source)

        recognized_text = recognizer.recognize_google(audio, language=language)

        # Clean up temporary audio file
        os.remove(temp_audio_path)

        return {"recognized_text": recognized_text}
    except sr.UnknownValueError:
        raise HTTPException(status_code=400, detail="Could not understand the audio")
    except sr.RequestError as e:
        raise HTTPException(status_code=500, detail=f"Recognition error: {e}")
    except Exception as e:
        print(f"Error: {e}")  # Log error
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/speak")
async def speak(request: SpeakRequest):
    """Speak out a given text."""
    if not request.text:
        raise HTTPException(status_code=400, detail="No text provided.")
    try:
        engine.say(request.text)
        engine.runAndWait()
        return {"message": "Text spoken successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

