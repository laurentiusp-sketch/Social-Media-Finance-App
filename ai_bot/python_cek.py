import google.generativeai as genai

# Masukkan API Key kamu di sini
GEMINI_KEY = "AIzaSyCDSOH7CjwWQRfWQVmTc6jk_8DWbGf_OVE" 

genai.configure(api_key=GEMINI_KEY)

print("🔍 Sedang mencari model yang tersedia...")
try:
    available = False
    for m in genai.list_models():
        if 'generateContent' in m.supported_generation_methods:
            print(f"- {m.name}")
            available = True
    
    if not available:
        print("❌ Tidak ada model yang ditemukan. Cek API Key atau Region kamu.")
        
except Exception as e:
    print(f"❌ Error: {e}")