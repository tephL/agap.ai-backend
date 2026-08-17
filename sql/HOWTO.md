### For pulling the database
This will import the database details to your local psql server so long you already have a `kap
``` bash
psql -U username -d db_name -f sql/schema.sql
`

### For pushing your updates
When you make changes to the database do this so that the changed schema file gets committed too
``` bash
pg_dump -U username -d db_name -F p -f sql/schema.sql
```
