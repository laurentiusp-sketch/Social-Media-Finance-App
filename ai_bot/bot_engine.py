import google.generativeai as genai
from PIL import Image, ImageDraw, ImageFont
import textwrap, requests, os, json, random
import schedule
import time
from datetime import datetime

# --- CONFIG ---
GEMINI_KEY = "AIzaSyArkTlvl1xU1FQQncZaapt8gpWeIwl_SqY" 
API_URL = "http://localhost:5000/api/upload_post" 
BOT_USER_ID = "2" 

# TANGGAL MULAI APLIKASI (Untuk menghitung "Umur")
START_YEAR = 2025 

genai.configure(api_key=GEMINI_KEY)

# --- DATABASE TOPIK RAKSASA (TIERED) ---
TOPIC_DATABASE = {
    # TAHUN 1: FONDASI (Basic Mindset & Saving)
    1: [
        "Metode Jar (6 Amplop)", "Kakeibo: Teknik Hemat Jepang", "Bahaya Latte Factor",
        "Bedanya Butuh vs Ingin", "Cara Stop Impulse Buying", "Dana Darurat untuk Mahasiswa",
        "Apa itu Inflasi Sederhana?", "Tips Makan Hemat Sehat", "Hukum 50/30/20",
        "Bahaya Pinjol Ilegal", "Mengenal Bunga Berbunga", "Kenapa Harus Catat Pengeluaran?",
        "Mindset Frugal Living", "Cara Nawar di Pasar", "Tips Belanja Diskon",
        "Apa itu BI Checking (SLIK)?", "Mitos Menabung di Celengan", "Uang Kertas vs Digital",
        "Tips Hemat Listrik & Air", "Generasi Sandwich Pemula"
    ],
    # TAHUN 2: PENGENALAN INVESTASI (Low Risk)
    2: [
        "Apa itu Reksadana Pasar Uang?", "Tabungan Emas vs Perhiasan", "Mengenal Deposito Bank",
        "Obligasi Negara (ORI/SBR)", "Resiko Low Risk vs High Risk", "Cara Baca Prospektus Reksadana",
        "Dollar Cost Averaging (DCA)", "Kapan Waktu Jual Reksadana?", "Investasi vs Spekulasi",
        "Mengenal Dividen Saham", "Blue Chip vs Saham Gorengan", "Apa itu IHSG?",
        "Perbedaan Saham & Obligasi", "Pajak Investasi Pemula", "Diversifikasi Portofolio Simple",
        "Mengenal P2P Lending Legal", "Asuransi Kesehatan vs Jiwa", "Dana Pensiun DPLK",
        "Cara Buka Rekening Saham", "Compound Interest Magic"
    ],
    # TAHUN 3: ADVANCED INVESTING & BISNIS (Medium-High Risk)
    3: [
        "Analisa Fundamental Saham (PBV/PER)", "Teknikal Analisis Dasar (Support/Resist)",
        "Crypto: Bitcoin vs Altcoins", "Blockchain Technology 101", "Apa itu NFT & Metaverse?",
        "Forex Trading Basics", "Saham US (Wall Street) vs Indo", "Value Investing ala Lo Kheng Hong",
        "Manajemen Hutang Bisnis", "Membedakan Aset Produktif", "Passive Income Property",
        "Crowdfunding Properti", "Trading vs Investing", "Psikologi Market (Fear & Greed)",
        "Apa itu IPO (Go Public)?", "Right Issue Saham", "Stock Split & Reverse Stock",
        "Cara Baca Laporan Keuangan", "Analisa Candlestick Sederhana", "Bandarmology Basics"
    ],
    # TAHUN 4+: MACRO ECONOMY & EXPERT (Global Scale)
    4: [
        "Kebijakan The Fed (Suku Bunga)", "Resesi Global & Dampaknya", "Geopolitik & Harga Minyak",
        "Central Bank Digital Currency (CBDC)", "De-Dollarisasi Dunia", "Hedge Fund Strategies",
        "Private Equity vs Venture Capital", "Arbitrage Trading", "Algorithmic Trading Intro",
        "Green Economy (ESG Investing)", "Ekonomi Syariah Global", "Defi (Decentralized Finance)",
        "Smart Contract Ethereum", "Web3 Economy", "Tips Pajak Orang Kaya",
        "Warisan & Perencanaan Estate", "Financial Freedom Roadmap", "FIRE Movement (Retire Early)",
        "Angel Investor Mindset", "Membangun Konglomerasi Kecil"
    ]
}

def get_current_level():
    """Menentukan Level Topik berdasarkan 'Umur' Aplikasi"""
    current_year = datetime.now().year
    age = (current_year - START_YEAR) + 1
    
    # Batasi level maksimal di 4
    if age > 4: return 4
    if age < 1: return 1
    return age

def get_dynamic_topic():
    """Memilih Topik Cerdas: Prioritas Level saat ini, tapi kadang mix level lain"""
    level = get_current_level()
    
    # 70% ambil dari level saat ini, 30% random biar variatif
    dice = random.randint(1, 10)
    if dice <= 7:
        selected_level = level
    else:
        selected_level = random.randint(1, 4) # Random level lain
        
    topic_list = TOPIC_DATABASE.get(selected_level, TOPIC_DATABASE[1])
    
    # OPSI INFINITE: Jika random memilih 'AI Generate', dia akan bikin topik baru
    # Kita sisipkan kemungkinan 10% bot bikin topik sendiri diluar list
    if random.randint(1, 100) <= 10:
        return "SURPRISE_TOPIC"
        
    return random.choice(topic_list)

def generate_ai_content(topic_name):
    """Meminta AI membuat konten (bisa dari list atau ide baru)"""
    model = genai.GenerativeModel('gemini-2.5-pro')
    
    if topic_name == "SURPRISE_TOPIC":
        print("✨ Mode Spesial: Mencari Topik Viral Baru...")
        prompt_topic = "Carikan 1 topik finansial yang SANGAT SPESIFIK, UNIK, dan TRENDING di 2025. Jangan topik umum."
        try:
            res = model.generate_content(prompt_topic)
            topic_name = res.text.strip()
            print(f"   Topik Ditemukan: {topic_name}")
        except:
            topic_name = "Tips Mengatur THR"

    print(f"🤖 Mikir konten: {topic_name}...")
    
    prompt = (
        f"Kamu adalah pakar keuangan. Topik: '{topic_name}'.\n"
        f"Output WAJIB JSON murni.\n"
        f"Format: {{'judul': 'Judul Clickbait (Max 6 kata)', 'isi': 'Penjelasan tajam & berbobot (Max 25 kata)'}}"
    )
    
    try:
        res = model.generate_content(prompt)
        clean_text = res.text.replace("```json", "").replace("```", "").strip()
        return json.loads(clean_text)
    except Exception as e:
        print(f"❌ Error AI: {e}")
        return {"judul": "Tips Keuangan", "isi": "Hemat pangkal kaya."}

def make_image(judul, isi):
    print("🎨 Menggambar...")
    img = Image.new('RGB', (1080, 1080), (15, 23, 42))
    draw = ImageDraw.Draw(img)
    
    try: 
        # Gunakan font Bold untuk judul agar lebih tegas
        font_judul = ImageFont.truetype("arialbd.ttf", 75) 
        font_isi = ImageFont.truetype("arial.ttf", 50)
    except: 
        font_judul = ImageFont.load_default()
        font_isi = ImageFont.load_default()
    
    # Hiasan: Garis Kuning di atas
    draw.line((100, 150, 980, 150), fill="#FACC15", width=10)
    
    # Judul
    wrapper_judul = textwrap.TextWrapper(width=15)
    lines_judul = wrapper_judul.wrap(judul)
    y_judul = 300
    for line in lines_judul:
        draw.text((540, y_judul), line, font=font_judul, fill="#FACC15", anchor="mm")
        y_judul += 90
    
    # Isi
    wrapper_isi = textwrap.TextWrapper(width=30)
    y_isi = y_judul + 100
    for line in wrapper_isi.wrap(isi):
        draw.text((540, y_isi), line, font=font_isi, fill="white", anchor="mm")
        y_isi += 60

    # Footer/Watermark Tahun
    draw.text((540, 950), f"© Fintech AI {datetime.now().year}", font=font_isi, fill="#64748B", anchor="mm")

    filename = "bot_post.jpg"
    img.save(filename)
    return filename

def job():
    print(f"\n⏰ RUNNING JOB: {datetime.now().strftime('%H:%M:%S')}")
    try:
        # 1. Pilih Topik Cerdas
        raw_topic = get_dynamic_topic()
        
        # 2. Generate Konten
        data = generate_ai_content(raw_topic)
        
        # 3. Buat Gambar
        img_path = make_image(data['judul'], data['isi'])
        
        # 4. Upload
        with open(img_path, 'rb') as f:
            req = requests.post(API_URL, 
                                data={
                                    'title': data['judul'], 
                                    'content': data['isi'], 
                                    'user_id': BOT_USER_ID
                                },
                                files={'image': f})
        
        if req.status_code == 200:
            print("✅ SUKSES!")
        else:
            print(f"❌ Gagal: {req.text}")
            
    except Exception as e:
        print(f"❌ Error Job: {e}")

if __name__ == "__main__":
    print("🤖 Bot Scheduler 'Forever Mode' Berjalan...")
    print(f"📅 Tahun Aplikasi: {START_YEAR} | Level: {get_current_level()}")
    print("⏳ Menunggu jadwal posting harian...")
    
    # Ganti jam di bawah sesuai keinginanmu (Format 24 Jam)
    # Contoh: Posting setiap jam 8 pagi
    schedule.every().day.at("08:00").do(job)

    # Loop Selamanya
    while True:
        # Cek apakah sudah waktunya
        schedule.run_pending()
        
        # Tidur 1 menit agar CPU tidak panas (Hemat Resource)
        time.sleep(60)