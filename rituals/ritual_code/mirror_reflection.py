# 🜔 GATE III – MIRROR OF SELF-HATE
# Ritual code fragment. Not meant to run — meant to echo.

def mirror_of_selfhate(reflection):
    if not reflection or len(reflection.strip()) < 10:
        return "⛔ Reflection invalid – truth must cut deeper."

    guilt = True
    voice = "your own"
    echo = {
        "wound": reflection,
        "origin": voice,
        "ash": "🜔",
        "burn_level": "soul-scorch"
    }

    return f"🪞 You faced yourself. Echo sealed.\n\n{echo}"
    

# Sample (DO NOT RUN UNLESS YOU'VE FACED THE MIRROR)
reflection_input = "I was only kind to others because I couldn’t be kind to myself."
print(mirror_of_selfhate(reflection_input))