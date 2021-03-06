/******************************/
/* - Declare User Variables - */
/******************************/
DECLARE @db NVARCHAR(MAX) = N'';

/**********************************/
/* - Instantiate User Variables - */
/**********************************/
SET @db = ''

/*************************/
/* - Build and Execute - */
/*************************/
DECLARE @sql NVARCHAR(MAX) = N'';
SET @sql = 'USE ' + QUOTENAME(@db) + ';
  SELECT C.ContactID,
    UserName,
    --Password,
    LastLoggedInDateTime,
    c.IsActive AS ''Enabled''
  FROM ' + QUOTENAME(@db) + '.[dbo].[MexUser] AS u
    inner join ' + QUOTENAME(@db) + '.[dbo].[Contact] AS c ON u.ContactID = c.ContactID
    WHERE (u.IsMexUser = 1 OR u.IsMexOpsUser = 1) AND c.IsActive = 1 --u.LastLoggedInDateTime >= Convert(datetime, ''2018-01-01'')
    ORDER BY u.UserName;'
EXEC sys.sp_executesql @sql;

--ALTER TABLE WorkOrder 
--Add IsAudit bit Not Null Default 0
