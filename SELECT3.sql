/*
Задача: Написать одним запросом на языке PL/SQL для Oracle. Нужно посчитать количество чеков, в которых куплено больше 2-х пар любой обуви	
и есть любой товар из категории туризм.
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
        t2.category IN ('РѕР±СѓРІСЊ','С‚СѓСЂРёР·Рј')
    GROUP BY
        id_check,
        category
    HAVING 
        (SUM_quan > 2 AND
        category='РѕР±СѓРІСЊ') OR
        (SUM_quan >= 1 AND
        category='С‚СѓСЂРёР·Рј')
)
SELECT 
    COUNT(DISTINCT id_check)
FROM 
    tbl
WHERE 
    CNT_check = 2
