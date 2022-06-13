USE [ncu_database]
GO
/****** Object:  UserDefinedFunction [dbo].[date_different]    Script Date: 2022/6/5 ¤U¤È 05:31:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[number_of_shares_calculate]
(
	@stock_price real,
	@budget int
)
RETURNS @result_tabel TABLE   
(  
    [price] int NOT NULL,
	[share_count] int NOT NULL
)  
AS
BEGIN
	DECLARE @tmp_share_count int
	SET @tmp_share_count = FLOOR(@budget / @stock_price)

	INSERT INTO @result_tabel
	VALUES (@tmp_share_count*@stock_price, @tmp_share_count)

	RETURN
END