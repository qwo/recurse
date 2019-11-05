## Mastermind 


## Two Players 
## 6 colors
## First Guess 

TRYS = 10
MASTERMIND_CODE = ['r', 'g', 'r', 'b']
import getpass

def play():
    characterset = "roygbv"
    print("pick master mind code, valid characters {}".format(characterset))
    MASTERMIND_CODE = getpass.getpass()
    for i in range(0, TRYS):
        inputz = input()
        check = guess(MASTERMIND_CODE, inputz)
        if check[0] == 4:
            print('You Won!')
            break
        else:
            printer(check, inputz)
            
    else:
        print('You Lost!')

def printer(check, string):
    # print(MASTERMIND_CODE)
    print('Your Guess was: {}, BlackPin {}, WhitePin {}'.format(string, check[0], check[1]))

def guess(master, string):
    black_pin = 0
    white_pin = 0
    reference = []
    not_in  = []
    for n in range(0,4):
        if master[n] == string[n]:
            black_pin +=1
        else: 
            not_in.append(string[n])
            reference.append(master[n])
    for n in not_in:
        if n in reference: 
           white_pin +=1
           reference.remove(n)
    return (black_pin, white_pin)    
        

if __name__ == "__main__":
    play()

# mastermind, guess, black / white
assert(guess('rgrb', 'rgrb') == (4,0))
assert(guess('rgrb', 'rrrr') == (2,0)) # 2 0 
assert(guess('rgrb', 'bbbb') == (1,0)) 
assert(guess('rgrb', 'rbrr') == (2,1)) 


        
    
