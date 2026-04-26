from pathlib import Path
from PIL import Image

# 현재 이 파이썬 파일이 있는 폴더
BASE_DIR = Path(__file__).resolve().parent

# 변환할 확장자
TARGET_EXTS = [".png", ".jpg", ".jpeg"]

# webp 품질
QUALITY = 95

# 원본 삭제 여부
DELETE_ORIGINAL = False

for file_path in BASE_DIR.rglob("*"):
    if file_path.suffix.lower() not in TARGET_EXTS:
        continue

    output_path = file_path.with_suffix(".webp")

    try:
        with Image.open(file_path) as img:
            # 투명 PNG 대응
            if img.mode in ("RGBA", "LA"):
                img.save(output_path, "WEBP", quality=QUALITY, lossless=False)
            else:
                img = img.convert("RGB")
                img.save(output_path, "WEBP", quality=QUALITY)

        print(f"변환 완료: {file_path.name} -> {output_path.name}")

        if DELETE_ORIGINAL:
            file_path.unlink()
            print(f"원본 삭제: {file_path.name}")

    except Exception as e:
        print(f"변환 실패: {file_path} / 이유: {e}")

print("전체 변환 완료!")