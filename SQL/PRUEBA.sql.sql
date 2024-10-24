
------------------------------FFT------------------------------------

SELECT *
FROM based_deductibles
WHERE
    user_id = 5727 
    and fft_id= 2957;

SELECT *
from crawling
WHERE
    user_id = '19887'
    and "type" = 'TAX_COMPLIANCE';



SELECT STATUS FROM FFT WHERE PERIOD = '2024-9';


UPDATE fft SET STATUS = 'IN_PROGRESS' WHERE PERIOD = '2024-9'; 


