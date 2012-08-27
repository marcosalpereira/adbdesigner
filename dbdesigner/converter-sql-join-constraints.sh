sed 'N;s/\(ALTER TABLE .*\)\n\( \+ADD CONSTRAINT\)/\1\2/;P;D;' < $1 > /tmp/1
sed 'N;s/\(ALTER TABLE .*\)\n\( \+FOREIGN KEY\)/\1\2/;P;D;' < /tmp/1 > /tmp/2
sed 'N;s/\(ALTER TABLE .*\)\n\( \+REFERENCES\)/\1\2/;P;D;' < /tmp/2 > $2

