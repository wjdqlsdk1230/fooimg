#!/usr/bin/env python3
"""
이미지 메타데이터 일괄 제거
- JPEG/WebP 재압축 없음
- PNG 픽셀 데이터 유지
- 원본은 건드리지 않고 출력 폴더에 복사
- ExifTool 설치 필요
"""

from pathlib import Path
import shutil
import subprocess
import sys

SUPPORTED_EXTENSIONS = {
    ".png", ".jpg", ".jpeg", ".webp",
    ".bmp", ".tiff", ".tif"
}


def strip_metadata(input_path: Path, output_path: Path) -> bool:
    try:
        # 먼저 원본 파일을 출력 폴더로 그대로 복사
        shutil.copy2(input_path, output_path)

        # 복사본에서 메타데이터만 제거
        result = subprocess.run(
            [
                "exiftool",
                "-all=",
                "-overwrite_original_in_place",
                str(output_path),
            ],
            capture_output=True,
            text=True,
        )

        if result.returncode != 0:
            print(result.stderr.strip())
            return False

        return True

    except FileNotFoundError:
        print("ExifTool이 설치되어 있지 않습니다.")
        return False

    except Exception as e:
        print(f"[오류] {input_path.name}: {e}")
        return False


def process_folder(input_dir: Path, output_dir: Path) -> None:
    if input_dir.resolve() == output_dir.resolve():
        print("입력 폴더와 출력 폴더는 서로 달라야 합니다.")
        return

    output_dir.mkdir(parents=True, exist_ok=True)

    files = sorted(
        file for file in input_dir.iterdir()
        if file.is_file() and file.suffix.lower() in SUPPORTED_EXTENSIONS
    )

    if not files:
        print("처리할 이미지 파일이 없습니다.")
        return

    print(f"총 {len(files)}개 파일 처리 시작...\n")

    success = 0

    for index, input_path in enumerate(files, 1):
        output_path = output_dir / input_path.name

        print(
            f"[{index}/{len(files)}] {input_path.name} ... ",
            end="",
            flush=True,
        )

        if strip_metadata(input_path, output_path):
            print("완료")
            success += 1
        else:
            print("실패")

    print(f"\n처리 완료: {success}/{len(files)}개 성공")
    print(f"출력 폴더: {output_dir.resolve()}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("사용법: python strip_metadata.py <입력폴더> <출력폴더>")
        print("예시: python strip_metadata.py ./comfy_output ./cleaned")
        sys.exit(1)

    input_folder = Path(sys.argv[1])
    output_folder = Path(sys.argv[2])

    if not input_folder.is_dir():
        print(f"입력 폴더가 존재하지 않습니다: {input_folder}")
        sys.exit(1)

    process_folder(input_folder, output_folder)