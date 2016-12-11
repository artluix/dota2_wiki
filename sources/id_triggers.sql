declare
    tableName varchar2(70);
    cursor c1 is
        select sequence_name from user_sequences;
    cursor c2 is
        select table_name from user_tab_columns
        where column_name = 'ID';
begin
    for s in c1 loop
        execute immediate ('drop sequence ' || s.sequence_name);
    end loop;
    
    for t in c2 loop
        tableName := t.table_name;
        execute immediate ('create sequence ' || tableName || '_seq');
        execute immediate (
                            'create or replace trigger tr_' || tableName || '_seq
                                before insert on ' || tableName || '
                                for each row
                            begin
                                select ' || tableName || '_seq.nextval into :new.id from dual;
                            end;'
                            );
    end loop;
end;
/