declare
    tableName varchar2(50);
    cursor c1 is
        select table_name from user_tables;
begin
    for t in c1 loop
        tableName := t.table_name;
        execute immediate (
                            'create or replace trigger tr_' || substr(tableName, 1, 22) || '_log
                                after insert or update or delete on ' || tableName || '
                                for each row
                            declare 
                                opName varchar2(20);
                            begin
                                if inserting then
                                    opName := ''Insert to '';
                                elsif updating then
                                    opName := ''Update '';
                                else
                                    opName := ''Delete from '';
                                end if;
                                
                                WriteToLog(opName || ' || '''' || tableName || '''); 
                            end;'
                            );
    end loop;
end;
/