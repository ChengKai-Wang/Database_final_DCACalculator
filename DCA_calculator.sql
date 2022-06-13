CREATE OR ALTER PROCEDURE [DCA_calculator]
(
	@stock_number varchar(10),
	@start_date date,
	@end_date date,
	@period int,
	@budget int
)
AS
BEGIN
	DECLARE @date date
	DECLARE @total_money int
	DECLARE @money_tmp int
	DECLARE @total_share int
	DECLARE @share_tmp int
	DECLARE @earn int
	DECLARE @price int
	DECLARE @ROI float
	DECLARE @counter int
	SET @counter = 0
	SET @total_money = 0
	SET @total_share = 0
	CREATE TABLE #return_table(
		Date date,
		money int,
		share int,
		earn int,
		ROI float,
		price int
	)

	declare cur CURSOR LOCAL for
		select date, price from find_price(@stock_number, @start_date, @end_date) order by date asc
	open cur

	fetch next from cur into @date, @price

	while @@FETCH_STATUS = 0
	BEGIN
		IF @counter = @period
		BEGIN
			SET @counter = 0
		END

		IF @counter = 0
		BEGIN
			-- save money
			select @money_tmp=price, @share_tmp=share_count from number_of_shares_calculate(@price, @budget)
			SET @total_money = @total_money + @money_tmp
			SET @total_share = @total_share + @share_tmp			
		END

		SET @counter = @counter + 1

		SET @earn = (@total_share * @price) - @total_money
		SET @ROI = CAST(@earn AS FLOAT) / CAST(@total_money AS FLOAT)

		INSERT INTO #return_table (Date, money, share, earn, ROI, price)
		VALUES (@date, @total_money, @total_share, @earn, @ROI, @price)

		fetch next from cur into @date, @price
	END

	select * from #return_table order by date asc

	close cur
	deallocate cur
END

--EXEC DCA_calculator '1326', '20210103', '20220103', 5, 200000