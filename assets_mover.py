import os
import shutil

# Define the asset directories you want to clean up
TARGET_DIRS = [
    "assets/preload",
    "assets/shared",
    "assets/impostor"
]

def sort_folder(base_path):
    # We look for a folder named 'images' or 'images-png' where your mixed files are
    images_path = os.path.join(base_path, "images")
    if not os.path.exists(images_path):
        images_path = os.path.join(base_path, "images-png")
        if not os.path.exists(images_path):
            print(f"Skipping {base_path}: No images folder found.")
            return None

    # Create paths for the clean new folders
    png_dir = os.path.join(base_path, "images-png_TEMP")
    astc_dir = os.path.join(base_path, "images-astc_TEMP")

    os.makedirs(png_dir, exist_ok=True)
    os.makedirs(astc_dir, exist_ok=True)

    print(f"Scanning and sorting files in {images_path}...")

    # Dynamic counters for this specific folder
    folder_counts = {"png": 0, "astc": 0, "xml_other": 0}

    # Scan through all the mixed files
    for root, dirs, files in os.walk(images_path):
        for file in files:
            file_path = os.path.join(root, file)
            # Calculate relative path to maintain subfolders (like /mira/ or /characters/)
            rel_path = os.path.relpath(file_path, images_path)
            
            if file.endswith(".png"):
                dest = os.path.join(png_dir, rel_path)
                os.makedirs(os.path.dirname(dest), exist_ok=True)
                shutil.move(file_path, dest)
                folder_counts["png"] += 1
                
            elif file.endswith(".astc"):
                dest = os.path.join(astc_dir, rel_path)
                os.makedirs(os.path.dirname(dest), exist_ok=True)
                shutil.move(file_path, dest)
                folder_counts["astc"] += 1
                
            elif file.endswith(".xml"):
                # XMLs are needed by BOTH platforms, so copy to both
                dest_png = os.path.join(png_dir, rel_path)
                dest_astc = os.path.join(astc_dir, rel_path)
                os.makedirs(os.path.dirname(dest_png), exist_ok=True)
                os.makedirs(os.path.dirname(dest_astc), exist_ok=True)
                shutil.copy2(file_path, dest_png)
                shutil.copy2(file_path, dest_astc)
                folder_counts["xml_other"] += 1
                
            else:
                # Move any other files (like .txt data) to both just in case
                dest_png = os.path.join(png_dir, rel_path)
                dest_astc = os.path.join(astc_dir, rel_path)
                os.makedirs(os.path.dirname(dest_png), exist_ok=True)
                os.makedirs(os.path.dirname(dest_astc), exist_ok=True)
                shutil.copy2(file_path, dest_png)
                shutil.copy2(file_path, dest_astc)
                folder_counts["xml_other"] += 1

    # Clean up the old mixed directory and swap in the newly sorted folders
    shutil.rmtree(images_path)
    os.rename(png_dir, os.path.join(base_path, "images-png"))
    os.rename(astc_dir, os.path.join(base_path, "images-astc"))
    
    total_folder_files = sum(folder_counts.values())
    print(f" -> Done with {base_path}! Processed {total_folder_files} files.\n")
    
    return folder_counts

if __name__ == "__main__":
    total_counts = {"png": 0, "astc": 0, "xml_other": 0}
    folders_processed = 0

    print("=========================================")
    print("      TEXTURE SORTING LOGS               ")
    print("=========================================\n")

    for folder in TARGET_DIRS:
        if os.path.exists(folder):
            counts = sort_folder(folder)
            if counts:
                folders_processed += 1
                total_counts["png"] += counts["png"]
                total_counts["astc"] += counts["astc"]
                total_counts["xml_other"] += counts["xml_other"]
                
    grand_total = sum(total_counts.values())

    print("=========================================")
    print("      FINAL SUMMARY BREAKDOWN            ")
    print("=========================================")
    print(f"Folders organized:    {folders_processed}")
    print(f"PNG files isolated:   {total_counts['png']}")
    print(f"ASTC files isolated:  {total_counts['astc']}")
    print(f"XML & Metadata files: {total_counts['xml_other']} (duplicated to both folders)")
    print("-----------------------------------------")
    print(f"GRAND TOTAL PROCESSED: {grand_total} files.")
    print("=========================================")