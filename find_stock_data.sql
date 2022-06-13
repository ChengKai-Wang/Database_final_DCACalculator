USE [02_21]
GO
/****** Object:  UserDefinedFunction [dbo].[find_date]    Script Date: 2022/6/2 ¤U¤È 06:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[find_stock_data]
(
	-- Add the parameters for the function here
	@company varchar(10),
	@start_date DATE,
	@end_date DATE
)
RETURNS @result_table TABLE 
(
	date date,
	price real
)
AS
BEGIN
	-- Declare the return variable here
		
	INSERT INTO @result_table
	SELECT date, c
		FROM stock_data
		WHERE company = @company AND [date] >= @start_date AND [date] <= @end_date 
		ORDER BY [date] DESC
		--AND @start_day + 244 - [day_of_stock] BETWEEN 0 AND @day_cnt-1)

	RETURN
END
