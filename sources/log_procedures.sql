create or replace procedure ClearLog
is
    f utl_file.file_type;
begin
    f := utl_file.fopen('LOG_DIR', 'log.log', 'w');
    utl_file.fclose(f);
end;
/

create or replace procedure ClearErrors
is
    f utl_file.file_type;
begin
    f := utl_file.fopen('LOG_DIR', 'error.log', 'w');
    utl_file.fclose(f);
end;
/

create or replace procedure WriteToLog(p_MessageStr in varchar2)
is
    l_OutFile utl_file.file_type;
    l_CurrentDate date;
begin
    select current_date into l_CurrentDate from dual;
    l_OutFile := utl_file.fopen('LOG_DIR', 'log.log' , 'a'); 
    utl_file.put_line(l_OutFile , p_MessageStr || ', ' || to_char(l_CurrentDate, 'DD-MON-YYYY HH24:MI:SS')); 
    utl_file.fclose(l_OutFile);
end;
/

create or replace procedure WriteError
is
    l_OutFile utl_file.file_type;
    l_ErrorLineStr varchar2(350);
    l_ErrorMsgStr varchar2(350);
begin
    l_OutFile := utl_file.fopen('LOG_DIR', 'error.log' , 'a'); 
    select regexp_replace(sys.dbms_utility.format_error_backtrace, '.*:', '') into l_ErrorLineStr from dual;
    l_ErrorLineStr := substr(l_ErrorLineStr, 1, length(l_ErrorLineStr) - 1);
    select regexp_replace(sys.dbms_utility.format_error_stack, '.*:', ':') into l_ErrorMsgStr from dual;
    utl_file.put_line(l_OutFile , 'Error is' || l_ErrorLineStr || l_ErrorMsgStr); 
    utl_file.fclose(l_OutFile);
end;
/

exec ClearLog();
exec ClearErrors();