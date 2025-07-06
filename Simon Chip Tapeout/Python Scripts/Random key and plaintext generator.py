import random

# Generate 32-bit random number
rand_32 = random.getrandbits(32)
print(f"Random 32-bit number (hex): {hex(rand_32)}")

# Generate 64-bit random number
rand_64 = random.getrandbits(64)
print(f"Random 64-bit number (hex): {hex(rand_64)}")
