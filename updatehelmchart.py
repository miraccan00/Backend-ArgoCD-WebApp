import yaml
import os

def update_helm_chart_image_tag(values_file_path, new_image_tag):
    # Get the absolute path of the values file
    values_file_path = os.path.join(os.path.dirname(__file__), values_file_path)

    # Check if the values file exists
    if not os.path.isfile(values_file_path):
        print(f"Error: Values file '{values_file_path}' does not exist.")
        return False

    # Load the values file
    with open(values_file_path, "r") as f:
        try:
            values = yaml.safe_load(f)
        except yaml.YAMLError as e:
            print(f"Error: Failed to load YAML from values file '{values_file_path}'.")
            print(f"Reason: {e}")
            return False

    # Update the image tag
    if "image" in values:
        values["image"]["tag"] = new_image_tag
    else:
        # If the 'image' key is not present, add it
        values["image"] = {"tag": new_image_tag}

    # Save the modified values back to the file
    with open(values_file_path, "w") as f:
        try:
            yaml.safe_dump(values, f)
        except yaml.YAMLError as e:
            print(f"Error: Failed to save YAML to values file '{values_file_path}'.")
            print(f"Reason: {e}")
            return False

    print("Image tag updated successfully.")
    return True
