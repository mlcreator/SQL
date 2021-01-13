/*
������: �������� ����� �������� �� ����� PL/SQL ��� Oracle. ����� ��������� ���������� �����, � ������� ������� ������ 2-� ��� ����� �����	
� ���� ����� ����� �� ��������� ������.
*/

WITH tbl AS(
    SELECT
        id_check, 
        category,
        SUM(quantity) AS SUM_quan,
        COUNT(category) OVER (PARTITION BY
            id_check) AS CNT_check
    FROM 
        table1 t1
    INNER JOIN 
        table2 t2
    ON 
        t2.art=t1.art AND
        t2.category IN ('обувь','туризм')
    GROUP BY
        id_check,
        category
    HAVING 
        (SUM_quan > 2 AND
        category='обувь') OR
        (SUM_quan >= 1 AND
        category='туризм')
)
SELECT 
    COUNT(DISTINCT id_check)
FROM 
    tbl
WHERE 
    CNT_check = 2
