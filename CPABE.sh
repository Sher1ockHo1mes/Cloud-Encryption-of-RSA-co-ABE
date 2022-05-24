#!/bin/bash 


# Generate system parameters
./oabe_setup -s CP

# Encrypt such that alice can decrypt but charlie cannot
# Floor range portion is thesame as (Floor > 2 and Floor < 5)
./oabe_enc -s CP -e "(Teacher or AuthorizedStudent or Specialist)" -i input.txt -o input.cpabe

# Generate key for Authorized
./oabe_keygen -s CP  -i "AuthorizedStudent" -o studentACP

# Generate key for student
./oabe_keygen -s CP -i "student" -o studentBCP

# Decrypt using alice's key -- should pass
./oabe_dec -s CP -k studentACP.key -i input.cpabe -o plainOK.input.txt

# Decrypt using charlie's key -- should fail
./oabe_dec -s CP -k studentBCP.key -i input.cpabe -o plainFail.input.txt




