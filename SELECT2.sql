/*
Описание: Есть две таблицы: таблица продаж (sales), в которой содержится информация о дате покупки, номере	
магазина, артикуле, который продали и количество проданных штук данного артикула.	
Вторая таблица (Prices) - справочник цен, в котором есть информация по ценам всех артикулов из таблицы	
sales

Задача: Написать запрос, который посчитает сумму продаж по 100му магазину за 1 января 2013 года.
Решение:
*/

SELECT
    DATE(datetime) AS date
    , SUM(quantity*price) AS sum   
    FROM
        sportmaster.sales s
    INNER JOIN
        (SELECT 
            art
            , price
            FROM (
                SELECT 
                    art
                    , price
                    , ROW_NUMBER() OVER (PARTITION BY art) AS num
                    , COUNT(*) OVER (PARTITION BY art) AS cnt
                FROM 
                    sportmaster.prices
            ) AS tbl
            WHERE 
                (num=1 AND cnt=1) OR 
                (num=2 AND cnt>1)
        ) AS tbl1
    ON
        s.art=tbl1.art AND 
        s.datetime=DATE('2013-01-01') AND
        s.shop=100
    GROUP BY
        DATE(datetime)
