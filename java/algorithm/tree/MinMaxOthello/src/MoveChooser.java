import java.util.List;
import java.util.ArrayList;

public class MoveChooser {
    static int[][] values = new int[][]{
        {120, -20, 20, 5, 5, 20, -20, 120},
        {-20, -40, -5, -5, -5, -5, -40, -20},
        {20, -5, 15, 3, 3, 15, -5, 20},
        {5, -5, 3, 3, 3, 3, -5, 5},
        {5, -5, 3, 3, 3, 3, -5, 5},
        {20, -5, 15, 3, 3, 15, -5, 20},
        {-20, -40, -5, -5, -5, -5, -40, -20},
        {120, -20, 20, 5, 5, 20, -20, 120}
    };
    public int depth; // how deep can search more
    public int alpha; // min border
    public int beta; // max border
    public int bestValue; // the best value the player can reach
    public Move bestMove; // the best move can choose
    public BoardState state; // current state

    static int cc = 0;


    public MoveChooser(BoardState boardState, int depth){
        this(boardState, depth, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }
    public MoveChooser(BoardState boardState, int depth, int alpha, int beta){
        state = boardState;
        this.depth = depth;
        this.alpha = alpha;
        this.beta = beta;
        if(isMax()){
            bestValue = Integer.MIN_VALUE;
        }else{
            bestValue = Integer.MAX_VALUE;
        }
    }


    public static Move chooseMove(BoardState boardState, int searchDepth){
        MoveChooser chooser = new MoveChooser(boardState, searchDepth-1);
        chooser.calculateValue();
        Move move = chooser.bestMove;
        // System.out.println("cc is " + cc);
        return move;
    }

    /** 
        Main process of min max algorithm
        1. calculate the leaf node's value
        2. update parent's alpha or beta
        3. if all children has value, choose min or max for parent's value
    */
    public void calculateValue(){
        cc++;
        if(depth == 0 || state.gameOver()){
            bestValue = calculateState();
            return;
        }
        
        ArrayList<Move> legalMoves = state.getLegalMoves();
        if(legalMoves.isEmpty()){
            BoardState nextState = state.deepCopy();
            nextState.colour *= -1;
            MoveChooser next = new MoveChooser(nextState, depth-1,alpha,beta);
            next.calculateValue();
            update(next.bestValue, null);
            if(alpha >= beta){
                return;
            }
        }else{
            for(Move move : legalMoves){
                BoardState nextState = state.deepCopy();
                nextState.makeLegalMove(move.x, move.y);
                MoveChooser next = new MoveChooser(nextState, depth-1,alpha,beta);
                next.calculateValue();
                update(next.bestValue, move);
                if(alpha >= beta){
                    return;
                }
            }
        }
    }

    // update bounder and best value
    private void update(int value, Move move){
        if(isMax()){
            if(value > bestValue){
                bestValue = value;
                bestMove = move;
            }
            if(value > alpha){
                alpha = value;
            }
        }else{
            if(value < bestValue){
                bestValue = value;
                bestMove = move;
            }
            if(value < beta){
                beta = value;
            }
        }
    }

    /** black choose max, white choose min */
    public boolean isMax(){
        return state.colour == -1;
    }

    /** count black items value */
    public int calculateState(){
        int score = 0;
        for(int i=0;i<8;i++){
            for(int j=0;j<8;j++){
                if(state.getContents(i, j) == -1){
                    score += values[i][j];
                }
            }
        }
        return score;
    }



}
