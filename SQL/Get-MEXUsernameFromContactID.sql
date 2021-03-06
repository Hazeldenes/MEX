/******************************/
/* - Declare User Variables - */
/******************************/
DECLARE @db NVARCHAR(MAX) = N'';
DECLARE @contactID NVARCHAR(MAX) = N'';

/**********************************/
/* - Instantiate User Variables - */
/**********************************/
SET @db = ''
SET @contactID = '(c.ContactID = 2781 or c.ContactID = 1216)'

/*************************/
/* - Build and Execute - */
/*************************/
DECLARE @sql NVARCHAR(MAX) = N'';
SET @sql = 'USE ' + QUOTENAME(@db) + ';
    SELECT c.ContactID, UserName, LastLoggedInDateTime, IsMexUser, IsMexOpsUser, IsMexMobileUser FROM ' + QUOTENAME(@db) + '.[dbo].[MexUser] AS u
    INNER JOIN Contact c ON u.ContactID = c.ContactID
    WHERE (u.IsMexUser = 1 or u.IsMexOpsUser = 1) and ' + @contactID + '
    ORDER BY u.UserName;'
EXEC sys.sp_executesql @sql;