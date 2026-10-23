import sys
from collections import Counter

def count_vowels(file_path):
    vowels = 'aeiou'
    try:
        with open(file_path, 'r') as f:
            text = f.read().lower()
            # Filter for only vowels and count them
            vowel_counts = Counter(char for char in text if char in vowels)
            
            # Create a formatted string of the results
            result = ", ".join(f"{v}:{vowel_counts.get(v, 0)}" for v in vowels)
            print(result)
    except FileNotFoundError:
        print(f"Error: The file {file_path} was not found.")
        sys.exit(1)

if __name__ == "__main__":
    # Ensure a file path was provided as an argument
    if len(sys.argv) != 2:
        print("Usage: python frequency.py <file_path>")
        sys.exit(1)
        
    file_path = sys.argv[1]
    count_vowels(file_path)
