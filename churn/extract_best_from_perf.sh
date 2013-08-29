grep Best $1 | awk '{print $3}' | sed "s/(//" | cut -c1-5

