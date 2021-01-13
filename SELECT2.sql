/*
��������: ���� ��� �������: ������� ������ (sales), � ������� ���������� ���������� � ���� �������, ������	
��������, ��������, ������� ������� � ���������� ��������� ���� ������� ��������.	
������ ������� (Prices) - ���������� ���, � ������� ���� ���������� �� ����� ���� ��������� �� �������	
sales

������: �������� ������, ������� ��������� ����� ������ �� 100�� �������� �� 1 ������ 2013 ����.
�������:
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