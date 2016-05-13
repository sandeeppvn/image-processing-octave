class_apple_red=0;
class_apple_green=0;
class_apple_blue=0;

for i=1:10 
str=["apple" int2str(i) ".jpg"];  #input of machine learning images
image=imread(str);
red=image(:,:,1); 
red_mean=mean(mean(red));
green=image(:,:,2);
green_mean=mean(mean(green));
blue=image(:,:,3);
blue_mean=mean(mean(blue));
plot3(red_mean,green_mean,blue_mean,'rd');
hold on;

class_apple_red=class_apple_red+red_mean;
class_apple_green=class_apple_green+green_mean;
class_apple_blue=class_apple_blue+blue_mean;
i=i+1;
end

class_apple_red=class_apple_red/10;
class_apple_green=class_apple_green/10;
class_apple_blue=class_apple_blue/10;
plot3(class_apple_red,class_apple_green,class_apple_blue,'b*');
hold on;

#Let A be original reference vector of Apple
A= [class_apple_red class_apple_green class_apple_blue];
# A transpose is A'
# ||A||^2  ==  A'A,  ||A||^2 be sqr_Nom_A
sqr_Nom_A = A*A';
Nom_A=sqr_Nom_A**0.5;

class_banana_red=0;
class_banana_green=0;
class_banana_blue=0;

for i=1:10
str=["banana" int2str(i) ".jpg"];
image=imread(str);
red=image(:,:,1);
red_mean=mean(mean(red));
green=image(:,:,2);
green_mean=mean(mean(green));
blue=image(:,:,3);
blue_mean=mean(mean(blue));

plot3(red_mean,green_mean,blue_mean,'go');
hold on;

class_banana_red=class_banana_red+red_mean;
class_banana_green=class_banana_green+green_mean;
class_banana_blue=class_banana_blue+blue_mean;
i=i+1;
end

class_banana_red=class_banana_red/10;
class_banana_green=class_banana_green/10;
class_banana_blue=class_banana_blue/10;
plot3(class_banana_red,class_banana_green,class_banana_blue,'b*');
hold on;

#Let B be original reference vector of Banana
B= [class_banana_red class_banana_green class_banana_blue];
# B transpose is B'
# ||B||^2  ==  B'B,  ||B||^2 be sqr_Nom_B , Nom_B
sqr_Nom_B = B*B';
Nom_B=sqr_Nom_B**0.5;

input_image=imread("testimage1.jpg");
input_red=input_image(:,:,1);
input_red_mean=mean(mean(input_red));
input_green=input_image(:,:,2);
input_green_mean=mean(mean(input_green));
input_blue=input_image(:,:,3);
input_blue_mean=mean(mean(input_blue));
plot3(input_red_mean,input_green_mean,input_blue_mean,'k.');
hold on;
 
#Let T be test image vector
T= [input_red_mean input_green_mean input_blue_mean];
# T transpose is T'
# ||T||^2  ==  T'T,  ||T||^2 be sqr_Nom_T
sqr_Nom_T = T*T';
Nom_T=sqr_Nom_T**0.5;


#Let EA represnt error vector between T and A vectors
# vectorEA =  vectorT - vectorA
# magnitude of EA is value of error ==> ||EA|| -> Nom_EA
# Nom_EA = ||T-A|| == sqrroot(sqr_Nom_T + sqr_Nom_A + 2*Nom_T*Nom_A*cos@)
# cos@ is angle between T and A ==> (T'*A)/(NOM_T*NOM_A)
# Hence, on substitution and division, Nom_EA = sqrroot(sqr_Nom_T + sqr_Nom_A + 2*T'*A)
Nom_EA= (sqr_Nom_T + sqr_Nom_A - 2*A*T')**0.5;

#Let EB represnt error vector between T and B vectors
# vectorEB =  vectorT - vectorB
# magnitude of EB is value of error ==> ||EB|| -> Nom_EB
# Nom_EB = ||T-B|| == sqrroot(sqr_Nom_T + sqr_Nom_B + 2*Nom_T*Nom_B*cos@)
# cos@ is angle between T and B ==> (T'*B)/(NOM_T*NOM_B)
# Hence, on substitution and division, Nom_EB = sqrroot(sqr_Nom_T + sqr_Nom_B + 2*T'*B)
Nom_EB= (sqr_Nom_T + sqr_Nom_B - 2*T*B')**0.5;

#Compare the error values of both linearly regressed lines and detect if its an apple or not.
if(Nom_EA<Nom_EB)
printf("the image is an apple \n");
else
printf("the image is a banana \n");
end





