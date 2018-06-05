################################################################################
#Bearings and Range Model
#
#             x[t] = F * x[t-1] + v[t]
#             y[t] = h(x[t])   + e[t]
#
# v[t] ~ N(0,Q)
# e[t] ~ N(0,R)
#
#where h() is a nonlinear function
#################################################################################
rm(list=ls())
set.seed(34567)
library(MASS)
#############################################################
#Multivariate normal density

dmnorm <- function (x, mu, Sigma, df, log = FALSE) {
 
      if (!is.matrix(x))
          x <- rbind(x)
      p <- nrow(Sigma)
      ed <- eigen(Sigma, symmetric = TRUE)
      ev <- ed$values
      if (!all(ev >= -1e-06 * abs(ev[1])))
          stop("'Sigma' is not positive definite")
      ss <- if (!is.matrix(mu)) {
          x - rep(mu, each = nrow(x))
      } else {
          x - mu
      }
      inv.Sigma <- ed$vectors %*% (t(ed$vectors)/ev)
      quad <- 0.5 * rowSums((ss %*% inv.Sigma) * ss)
      fact <- -0.5 * (p * log(2 * pi) + sum(log(ev)))
      if (log)
          as.vector(fact - quad)
      else
          as.vector(exp(fact - quad))
 
 }
###################################################################
#Systematic resampling 

resampleSystematic = function(w){

N = length(w)
Q = cumsum(w)
T = vector(length=N)
index = vector(length=N)

T = seq(0,1-1/N,length.out=N) + runif(1)/N
T[N+1] = 1

i=1
j=1

while(i<=N){
    if (T[i]<Q[j]){
        index[i]=j
        i=i+1
    }else{j=j+1}
  }
return(index)
}
#######################################################################
#Systematic resampling 2

resampleSystematic2 = function(w){

arrange=order(w,decreasing=TRUE)
w = sort(w,decreasing=TRUE)
N = length(w)
N = N/2
Q = cumsum(w)
T = vector(length=N)
index = vector(length=N)

T = seq(0,1-1/N,length.out=N) + runif(1)/N
T[N+1] = 1

i=1
j=1

while(i<=N){
    if (T[i]<Q[j]){
        index[i]=j
        i=i+1
    }else{j=j+1}
  }
return(arrange[index])
}
################################################################################
#Setting up the scenario#

#Turn rate parameters
w1 = 0.000000001
w2 = (pi/180)*3 
w3 = w1
w4 = (pi/180)*5.6 
w5 = w1
w6 = (pi/180)*8.6 
w7 = w1
w8 = (pi/180)*-7.25
w9 = w1
w10 = (pi/180)*7.25
ws = c(rep(w1,60),rep(w2,60),rep(w3,30),rep(w4,64),rep(w5,26),rep(w6,32),rep(w7,28),rep(w8,38),rep(w9,22),rep(w10,40))
#changes occur at = (60,156,190,254,280,312,340,378)


P = 5000      #Number of particles
T = 400       #Length of observations
dt = 1

G = matrix(c(1,sin(w1)/w1*dt,0,-(1-cos(w1))*dt/w1,0,cos(w1)*dt,0,-sin(w1)*dt,0,(1-cos(w1))*dt/w1,1,sin(w1)*dt/w1,0,sin(w1)*dt,0,cos(w1)*dt),nrow=4,ncol=4,byrow=T) #Observation matrix

F = matrix(c(1,dt,0,0,0,1,0,0,0,0,1,dt,0,0,0,1),nrow=4,ncol=4,byrow=T)  #state transition matrix

x0 <- c(30000,300,30000,0) #Initial location of target

#Mean and covariance of prior density for the state
m0 = c(29800,275,30200,10)
C0 = diag(c(200,10,200,10))

delta <- 0.99 #Liu and West parameter

nu2= 2 #Noise parameter for state transitions

gamma = matrix(c(dt^2/2,0,dt,0,0,dt^2/2,0,dt),ncol=2,nrow=4,byrow=T) #scaling matrix for state noise

var1 = gamma%*%diag(nu2,2)%*%t(gamma) #Variance of state transition density

R = diag(c(50^2,0.0174533^2)) #Variance of observation density

sx=55000;sy=55000  #Sensor location

#Simulate data
X <- matrix(nrow=T,ncol=4)  #Matrix of unobserved states
Y <- matrix(nrow=T,ncol=2)  #Matrix of observations
X[1,] <- x0 #Initial position
for(t in 2:T){
  G = matrix(c(1,sin(ws[t])/ws[t],0,-(1-cos(ws[t]))/ws[t],0,cos(ws[t]),0,-sin(ws[t]),0,(1-cos(ws[t]))/ws[t],1,sin(ws[t])/ws[t],0,sin(ws[t]),0,cos(ws[t])),nrow=4,ncol=4,byrow=T)
X[t,] <- G%*%X[t-1,]+ gamma%*%mvrnorm(1,c(0,0),nu2*diag(1,2)) #State transitions
}
#Noisy range and bearings observations 
Y[,1] = sqrt((X[,1]-sx)^2+(X[,3]-sy)^2)
Y[,2] = atan2((X[,3]-sy),(X[,1]-sx))
Y = Y + mvrnorm(T,c(0,0),R)


#########################################################
#No changepoint assumed

PF.LW.RB = function(Y,m0,C0,delta,gamma,nu2,R,sx,sy,P){
  #Y - observations
  #m0 - prior mean of target
  #C0 - prior covariance of target
  #delta - Liu and West parameter
  #gamma - see transition equation
  #nu2 - variance of transition noise
  #R - variance of observation density
  #sx, sy - the x and y position of the sensor
  #P - number of particles
  
  #Set-up
  itime  = proc.time()[3]  #Start the clock
  f = function(ws,mt){x=mt[1,]+(sin(ws)/ws)*mt[2,]-((1-cos(ws))/ws)*mt[4,];xdot=cos(ws)*mt[2,]-sin(ws)*mt[4,];y=mt[3,]+((1-cos(ws))/ws)*mt[2,]+(sin(ws)/ws)*mt[4,];ydot=sin(ws)*mt[2,]+cos(ws)*mt[4,];z=rbind(x,xdot,y,ydot);return(z)} #Transition function
  h = function(x){a=sqrt((x[1,]-sx)^2+(x[3,]-sy)^2); b=atan2((x[3,]-sy),(x[1,]-sx)); z=rbind(a,b); return(z)} #Observation function
  T      = nrow(Y)               #Number of observations
  N      = length(m0)               #Dimension of state vector
  M      = ncol(Y)                  #Dimension of observations
  states  = matrix(0,T,N)           #Create a matrix to store the estimated states
  states[1,] = m0                   #First state
  theta    = rep(0,T)               # Store turn rate parameter estimates
  h2       = 1-((3*delta-1)/(2*delta))^2    # Smoothing parameter for Liu and West
  a        = sqrt(1-h2)                     # Shrinkage parameter
  ws       = runif(P,-pi/8,pi/8)  #Sample turn parameters from uniform distribution
  mt       = t(mvrnorm(P,m0,C0))  #Sample particle for the state vector
  w1 =  rep(1/P,P)                #Vector of weights for the particle filter
  w1 = w1/sum(w1)                 #Normalise the weights
  theta[1]     = sum(w1*ws)       #Estimate the turn rate parameter as t=1
  states[1,] = apply(w1*t(mt),2,sum) #Estimate the state at t=1
  #Loop
  for (t in 2:T){
   #Resampling
    mean.theta  = sum(w1*ws)     # mean of parameters
    cov.theta   = sum(w1*(ws-mean.theta)^2)      # covariance of parameters
    ms          = a*ws + (1-a)*matrix(mean.theta,P,1,byrow=T) # kernel locations

    pred.x = f(ms[,1],mt) #Resample particles using predictive likelihood p(y[t]|x[t-1])
    w0 =  dmnorm(t(h(pred.x)),Y[t,],R,log=TRUE) #Convert the weights to log scale for greater computational stability 
    weights  = exp(w0-max(w0))*w1         #Convert weights back to correct scale (2nd line of Alg. 2)
    weights = weights/sum(weights)        #Normalise the weights
    k       = resampleSystematic(weights)  #Resample with replacement
    mt      = mt[,k]                       #Update state with surviving particles
    ws      = ms[k,] + matrix(rnorm(length(k)),length(k),1)%*%chol(h2*cov.theta) #Sample new parameters from mixture of Gaussians (line 7 of Alg.2)
    ws      = ws[,1]
    
   # Propagating
      mt = f(ws,mt) + gamma%*%t(mvrnorm(P,rep(0,2),diag(nu2,2)))  #Propagate states
      w1 = dmnorm(t(h(mt)),Y[t,],R,log=TRUE)-w0[k] #Weight the particles (line 10 of Alg.2)
      w1 = exp(w1-max(w1)) #Rescale the weights
      w1 = w1/sum(w1)      #Normalise the weights
    
  states[t,] = apply(w1*t(mt),2,sum)   #Mean state estimate at time t
  theta[t]     = sum(w1*ws)            #Mean parameter estimate at time t
  }
  ctime = proc.time()[3] #Stop the clock
  cat(" Total time elapsed: ", round((ctime-itime)/60,2),"\n") #Record function execution time
  return(list(states=states,turn=theta))
}

#########################################################################
# LW for turn rate only with special resampling
PF.LW.CP.RB = function(Y,m0,C0,delta,gamma,nu2,R,sx,sy,P,p){
  #Y - observations
  #m0 - prior mean of target
  #C0 - prior covariance of target
  #delta - Liu and West parameter
  #gamma - see transition equation
  #nu2 - variance of transition noise
  #R - variance of observation density
  #sx, sy - the x and y position of the sensor
  #P - number of particles
  #p - probability of a changepoint

#Set-up
  itime  = proc.time()[3]
  f = function(ws,mt){x=mt[1,]+(sin(ws)/ws)*mt[2,]-((1-cos(ws))/ws)*mt[4,];xdot=cos(ws)*mt[2,]-sin(ws)*mt[4,];y=mt[3,]+((1-cos(ws))/ws)*mt[2,]+(sin(ws)/ws)*mt[4,];ydot=sin(ws)*mt[2,]+cos(ws)*mt[4,];z=rbind(x,xdot,y,ydot);return(z)} #Transition function
  h = function(x){a=sqrt((x[1,]-sx)^2+(x[3,]-sy)^2); b=atan2((x[3,]-sy),(x[1,]-sx)); return(cbind(a,b))} #Observation function
  T        = nrow(Y)                #Number of observations
  states   = matrix(0,T,4)          #Create a matrix to store the estimated states
  theta    = rep(0,T)               # Store turn rate parameter estimates
  h2       = 1-((3*delta-1)/(2*delta))^2    # Smoothing parameter for Liu and West
  a        = sqrt(1-h2)                     # Shrinkage parameter 
  ws       = runif(P,-pi/8,pi/8) #Sample turn parameters from uniform distribution
  logit.ws = log((ws+pi/8)/(pi/4)/(1-(ws+pi/8)/(pi/4))) #Logit transform the parameters onto the real line to remove boundary constraints
  mt       = t(mvrnorm(P,m0,C0)) #Sample particle for the state vector
  w1       = rep(1/P,P)          #Vector of weights for the particle filter
  thetas   = cbind(logit.ws)     #Parameters
  theta[1]  = w1%*%ws              #Estimate the turn rate parameter as t=1
  states[1,] = w1%*%t(mt)          #Estimate the state at t=1
  
    #Loop
  for (t in 2:T){
   #Resampling
    mean.theta  = w1%*%thetas     # mean of parameters
    cov.theta   = sum(w1*(ws-mean.theta)^2)      # covariance of parameters
    ms          = a*thetas + (1-a)*matrix(mean.theta,P,1,byrow=T) # kernel locations
    
    #Preweights of learnt parameters
    pred.x = f(pi/4*(exp(ms[,1])/(1+exp(ms[,1]))-0.5),mt) #Resample particles using predictive likelihood p(y[t]|x[t-1]) (mu in Alg.3)
    weights1 =  dmnorm(h(pred.x),Y[t,],R,log=TRUE) #Convert the weights to log scale for greater computational stability (this is w_{t,1} from Alg.3)

    #Preweights of fresh parameters
    ws       = runif(P,-pi/8,pi/8)    #fresh parameters (gamma in Alg.3)
    pred.x = f(ws,mt) #Resample particles using predictive likelihood p(y[t]|x[t-1]) (mu in Alg.3)
    weights2 = dmnorm(h(pred.x),Y[t,],R,log=TRUE) #w_{t,2} in Alg.3

    #Learnt parameters
    w3  = exp(weights1-max(weights1))             #Convert the weights back
    w0 = w3*w1                                    #Important! Need to multiply by w1 if we exclude the final resampling step at the end of Alg.3. Basically this is the same as in line 2 of Alg.2
    w0 = w0/sum(w0)                              #Normalise the weights
    #Fresh parameters
    w4 = exp(weights2-max(weights2))
    wA = w4*w1
    wA = wA/sum(wA)                              #Normalise the weights
    
      weights3 = c((1-p)*w0,p*wA)                #Union of the weights
    weights3=weights3/sum(weights3)              #Normalise the weights
    k = resampleSystematic2(weights3)            #Sample indices k
    k1      = k[k<=P]       #Learnt particles
    k2      = k[k>P]        #Fresh particles
    k2      = k2-P
    k       = c(k1,k2)       #Vector of indexes for both learnt and fresh particles
    wX      = c(w3[k1],w4[k2])       #Combined weights
    mt      = mt[,k]                 #Updated state vector
    thetas  = ms[k1] + matrix(rnorm(length(k1)),length(k1),1)%*%chol(h2*cov.theta) #Sample parameters using Liu and West (this is zeta in alg.3)
    ws      = c(pi/4*(exp(thetas)/(1+exp(thetas))-0.5),ws[k2]) #Combine learnt and fresh turn rate parameters (theta in Alg.3)
    
    # Propagating
      mt = f(ws,mt) +  gamma%*%t(sqrt(nu2)*mvrnorm(P,c(0,0),diag(1,2))) #State transition
      w1 = dmnorm(h(mt),Y[t,],R,log=TRUE)  
      w1 = exp(w1-max(w1))/wX              #Assign weights (wt in Alg.3)
      w1 = w1/sum(w1)                      #Normalise the weights
      states[t,] = w1%*%t(mt)              #Mean state estimate
      thetas      = cbind(log((ws+pi/8)/(pi/4)/(1-(ws+pi/8)/(pi/4)))) #Convert turn rate parameters back onto real line 
      theta[t]     = w1%*%ws   #Mean of turn rate parameters
  }
  ctime = proc.time()[3]
  cat(" Total time elapsed: ", round((ctime-itime)/60,2),"\n")
  return(list(states=states,pars=theta,thetas=thetas))
}

########################################################################


PF05 = PF.LW.CP.RB(Y,x0,C0,delta,gamma,nu2,R,sx,sy,P,0.05)


#Target track
par(mfrow=c(1,2))
plot(X[,1],X[,3],type='l',main='Trajectory',xlab="X",ylab="Y",xlim=c(20000,56000),ylim=c(30000,56000))
points(sx,sy,pch=6)
points(PF05$states[,1],PF05$states[,3],type='l',col='blue')


#Parameter estimates
plot(PF05$pars,type='l',xlab="Time",ylab="Parameter estimate")
points(ws,type='l',lty=2,col='red',lwd=2)
par(mfrow=c(1,1))

