function flag=kmodes(data ,k) 

%Matlab code for k-Modes algorithm

%Reference : Chaturvedi et al . K-Modes Clustering , Journal of Classification ,
%18:35-55(2001)

%data-input data matrix?\ %k-input number of clusters
dim = size(data);

%get the dimension of the data matrix
n=dim (1); d=dim (2);

%Declarations

%Memberships, vShip[i]=j means x_i is in the jth cluster 
vShip=zeros(1,n);
mModes=zeros(k,d); 

%Mode of each cluster 
Lprev=0; L=0;%Loss function values?
%Initialize modes
vrand = zeros(1,k);
vrand (1) = floor (n-rand+1);
mModes(1,:) = data(vrand(1),:); 

for i =2:k	bTag = 0; 
	while bTag==0
		bTag = 1;
		j=floor (n-rand+1);
		for s =1:( i-1)
			if  j==vrand(s)
				bTag=0;
			end 
		end
	end
	vrand(i) = j;
	mModes(i ,:) = data(vrand(i ) ,:);
end 
clear vrand ;
%Estimate vShip given the inital mModes
for i =1:n
	fprev = length(find(abs(data(i ,:)-mModes(1 ,:)) >0)); 
	vShip(i) = 1;
	for s=2:k
		f = length(find(abs(data(i ,:)-mModes(s ,:)) >0)); 
		if fprev>f
			fprev=f;
			vShip(i)=s;
		end 
	end
	L = L+fprev;
end

%Iteration phase , estimate vShip , estimate mModes
Lprev=n-d ;?while abs ( Lprev-L)>0
	Lprev=L;
	L=0;
	%Estimate mModes given the revised vShip 
	for s=1:k
		index = find(vShip == s ) ;
		for j =1:d
			A=sort(data (index, j) ) ;
			[b,m,nn]=unique(A);
			nL = length(m);
			nMax = m(1);
 			mModes ( s , j ) = b ( 1 ) ; 
			for i=2:nL
				if (m(i)-m(i-1))>nMax 
					nMax=m(i)-m(i-1);
					mModes (s, j) = b (i) ;
				end 
			end
		end 
	end
	%Estimate vShip given the estimate of mModes
	for i =1:n
			fprev = length(find(abs(data(i ,:)-mModes(1 ,:)) >0));
			vShip(i) = 1;
			for s=2:k
				f = length(find(abs(data(i ,:)-mModes(s ,:)) >0));
				if fprev>f
					fprev=f;
					vShip(i)=s;
				end 
			end
			L = L+fprev;
		end
		Lprev
		L
endfunction 
%flag=vShip ;
