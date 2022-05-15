clc
clear all
f=input("请输入函数(函数句柄类型,如@(x)cos(x)):");
X=input("请输入根的粗糙估计值或区间(如1或[0,1]):");
delta=input("请输入最大允许误差:");
main(f,X,delta);