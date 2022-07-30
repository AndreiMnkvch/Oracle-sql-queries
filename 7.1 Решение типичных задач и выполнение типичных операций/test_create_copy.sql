@echo GRANT CREATE ANY DIRECTORY TO exploration; | sqlplus abc/def@COMP 
@echo CREATE DIRECTORY LIBRARY_BACKUP AS 'C:\backup'; | sqlplus abc/def@COMP 
expdp abc/def@COMP schemas=abc directory=LIBRARY_BACKUP dumpfile=li-brary.dmp logfile=library_log.log