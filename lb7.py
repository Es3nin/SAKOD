import random
A=[]
a=[0,0,0,0,'0']
for x in range(0,35):
    a[0]=random.randint(1,1000000)
    a[1]=random.randint(1,12)
    a[2]=random.randint(1,32)
    a[3]=random.randint(1,200)+round(1/random.randint(3,9))
    a[4]='address hidden'
    A.append(a.copy())
A.append([0,0,0,0,'0'])
def linsearch(M,key):
    index=0
    while M[index]!=[0,0,0,0,'0']:
        if M[index][0]==key:
            print(M[index])
            break
        index+=1
    if M[index]==[0,0,0,0,'0']:
        print('Данные об квартире не найдены')
print(A)
linsearch(A,int(input('Введите искомый номер квартиры: ')))
