import os

# Specify the path to your index.ts file
index_ts_path = "./index.ts"

def ensure_exports_in_index(file_path):
    # Get the directory containing the index.ts file
    directory = os.path.dirname(file_path)

    # Find all `.entity.ts` files in the same directory
    entity_files = [
        f for f in os.listdir(directory)
        if f.endswith(".entity.ts") and f != "index.ts"
    ]

    # Generate the export lines for each .entity.ts file
    exports = [f"export * from './{os.path.splitext(f)[0]}';" for f in entity_files]

    # Read the existing lines in index.ts, if it exists
    if os.path.exists(file_path):
        with open(file_path, "r") as file:
            existing_lines = file.readlines()
    else:
        existing_lines = []

    # Convert lines to a set for quick lookup (stripped of whitespace for accuracy)
    existing_lines_set = set(line.strip() for line in existing_lines)

    # Track new lines to add if they are not already present
    missing_exports = [export for export in exports if export not in existing_lines_set]

    # If all exports are present, notify the user and return
    if not missing_exports:
        print("All necessary exports are already present in index.ts.")
        return

    # Append the missing exports to the file
    with open(file_path, "a") as file:
        for export in missing_exports:
            file.write(export + "\n")

    print("Missing exports added to index.ts.")

# Call the function with the specified path to index.ts
ensure_exports_in_index(index_ts_path)
