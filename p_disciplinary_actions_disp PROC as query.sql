USE [TM_TRACKING]
GO

/****** Object:  StoredProcedure [dbo].[p_disciplinary_actions_disp]    Script Date: 1/5/2017 2:43:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


DECLARE @TEAM_MEMBER_NUM int = null;
DECLARE @DISCIPLINARY_ACTION_ID int = null;
DECLARE @StartDate datetime = null;
DECLARE @EndDate datetime = null;
DECLARE @DEPT_CD char(5) = NULL;
DECLARE @IsSalaried BIT = NULL;

SET @DEPT_CD=N'55020';

/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		TM_TRACKING_DB
** Database		TM_TRACKING
** Object		p_disciplinary_actions_disp
** Description	Retrieves a list of a team member's disciplinary actions from the TM_TRACKING database.
**	
**
** ----------------
** Revision History
** ----------------
** Date		Version	Author	Description
** --------	-------	------	-----------
** 03/21/08	1.0		L.B.	Initial version
**
**
*********************************************************************************************************/
SET NOCOUNT ON

	SELECT *
	FROM DISCIPLINARY_ACTION d
	JOIN v_ALL_TEAM_MEMBERS t
	ON	d.TEAM_MEMBER_NUM = t.TEAM_MEMBER_NUM
		AND t.TEAM_MEMBER_STATUS_CD LIKE ('A%')
		AND 
			-- If t.SALARY_IND is ture or false(null) return true/false(null) rows
		((	CASE ISNULL(t.SALARY_IND, 0)
			WHEN 0 THEN 0
			ELSE t.SALARY_IND
			END
		 =
			CASE ISNULL(@IsSalaried,0)
			WHEN 0 THEN 0
			ELSE @IsSalaried
			END
		  )
			-- Or if @IsSalaried is null, we want to return select all rows to return
		 OR CASE ISNULL(convert(varchar(10),@IsSalaried),'a')
			WHEN 'a' THEN 2
			ELSE 0
			END
		 >	0
		)

		
		AND 1 =
			CASE ISNULL(@DEPT_CD ,1)
			WHEN 1 THEN 1
			-- Check if the teammember's dept_CD and @DEPT_CD are in common Dept group 
			ELSE dbo.f_HasCommonDeptGroup(@DEPT_CD, t.DEPT_CD)
			END		
	WHERE d.TEAM_MEMBER_NUM = 
		CASE 
			WHEN DATALENGTH(@TEAM_MEMBER_NUM) > 0 
			THEN @TEAM_MEMBER_NUM
			ELSE d.TEAM_MEMBER_NUM
		END
	AND
		d.DISCIPLINARY_ACTION_ID = 
		CASE 
			WHEN DATALENGTH(@DISCIPLINARY_ACTION_ID) > 0 
			THEN @DISCIPLINARY_ACTION_ID
			ELSE d.DISCIPLINARY_ACTION_ID
		END
	AND
	    (ISNULL(d.INCIDENT_DT,'01/01/1990') BETWEEN ISNULL(@StartDate,'01/01/1900') AND ISNULL(@EndDate,'01/01/3000'))
	ORDER BY INCIDENT_DT DESC	    

GO


