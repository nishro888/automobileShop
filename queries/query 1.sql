/*To add columns in table*/
ALTER TABLE notes 
ADD (color VARCHAR(10), locktype VARCHAR(10));
DESCRIBE notes;

/*To modify a column type*/
ALTER TABLE notes 
MODIFY locktype VARCHAR(20);
DESCRIBE notes;

/*To rename a column name*/
ALTER TABLE notes 
RENAME COLUMN locktype to smartlock;
DESCRIBE notes;

/*To delete column*/
ALTER TABLE notes DROP COLUMN color;
ALTER TABLE notes DROP COLUMN smartlock;
DESCRIBE notes;




