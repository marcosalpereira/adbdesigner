echo "<?xml version="1.0" encoding="UTF-8"?>"
echo "<database>"
sh converter-sql-join-constraints.sh $1 /tmp/joined.sql
sed -f $2 < /tmp/joined.sql
echo "</database>"
