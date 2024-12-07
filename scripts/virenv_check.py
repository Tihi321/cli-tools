import sys

if hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix):
    print(f"Virtual environment is active: {sys.prefix}")
else:
    print("No virtual environment active")