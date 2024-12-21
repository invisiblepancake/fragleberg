#!/bin/bash

# Path to your peanut inventory file
INVENTORY_FILE="./peanut_inventory.txt"

# Initialize inventory if it doesn't exist
if [[ ! -f $INVENTORY_FILE ]]; then
  echo "Salted: 20" > $INVENTORY_FILE
  echo "Unsalted: 15" >> $INVENTORY_FILE
  echo "Peanut Butter: 5" >> $INVENTORY_FILE
fi

# Randomly "consume" some peanuts
SALT=$(shuf -i 0-3 -n 1)
UNSALT=$(shuf -i 0-2 -n 1)
BUTTER=$(shuf -i 0-1 -n 1)

# Update inventory
sed -i "s/Salted: [0-9]*/Salted: $(( $(grep 'Salted:' $INVENTORY_FILE | awk '{print $2}') - SALT ))/" $INVENTORY_FILE
sed -i "s/Unsalted: [0-9]*/Unsalted: $(( $(grep 'Unsalted:' $INVENTORY_FILE | awk '{print $2}') - UNSALT ))/" $INVENTORY_FILE
sed -i "s/Peanut Butter: [0-9]*/Peanut Butter: $(( $(grep 'Peanut Butter:' $INVENTORY_FILE | awk '{print $3}') - BUTTER ))/" $INVENTORY_FILE

# Output the inventory
echo "Current Peanut Inventory:"
cat $INVENTORY_FILE

# Generate a peanut log for the commit message
PEANUT_LOG=$(cat $INVENTORY_FILE | awk '{print "  🥜 " $0}')
echo -e "Peanut Log Update:\n$PEANUT_LOG\n" > ./commit_msg.txt

# Add it to your git commit
git commit -S -F ./commit_msg.txt

