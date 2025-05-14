#!/bin/bash

i=6
while ((${i} <= 25));
do
    cp -r 4/ $i/
    echo "# ${i} билет

---

### 1 вопрос:

---

### 2 вопрос:

---

### 3 вопрос:
" > ${i}/readme.md
    i=$(( $i + 1 )) 
done