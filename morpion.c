#include <stdio.h>
#include <stdlib.h>


void afficheGrille(char **grille, int dim) {
    int x,y;
    
    for(x = 0; x < dim; x++) {
        printf("|");
        for(y = 0; y < dim; y++) {
            printf("%c|", grille[x][y]);
        }
        printf("\n");
    }
}


int testVictoireLigne(char **grille, int dim) {
    int x,y;
    int resLigneX = 0, resLigne0 = 0;
    
    for(x = 0; x < dim; x++) {
        for(y = 0; y < dim; y++) {
            if (grille[x][y] == '0') {
                resLigne0+=1;
            }
            else if (grille[x][y] == 'X') {
                resLigneX+=1;
            }
        }
        if (resLigneX == dim) {
            return 1;
        }
        else if (resLigne0 == dim) {
            return 2;
        }
        resLigne0 = 0;
        resLigneX = 0;
    }
    return 0;
}


int testVictoireColonne(char **grille, int dim) {
    int x,y;
    int resColonneX = 0, resColonne0 = 0;
    
    for(y = 0; y < dim; y++) {
        for(x = 0; x < dim; x++) {
            if (grille[x][y] == '0') {
                resColonne0+=1;
            }
            else if (grille[x][y] == 'X') {
                resColonneX+=1;
            }
        }
        if (resColonneX == dim) {
            return 1;
        }
        else if (resColonne0 == dim) {
            return 2;
        }
        resColonne0 = 0;
        resColonneX = 0;
    }
    return 0;
}


int testVictoireDiagoGauche(char **grille, int dim) {
    int x;
    int resDiagonaleX = 0, resDiagonale0 = 0;
    
    for(x = 0; x < dim; x++) {
        if (grille[x][x] == '0') {
            resDiagonale0+=1;
        }
        else if (grille[x][x] == 'X') {
            resDiagonaleX+=1;
        }
    }
    if (resDiagonaleX == dim) {
        return 1;
    }
    else if (resDiagonale0 == dim) {
        return 2;
    }
    resDiagonale0 = 0;
    resDiagonaleX = 0;

    return 0;
}


int testVictoireDiagoDroite(char **grille, int dim) {
    int x;
    int resDiagonaleX = 0, resDiagonale0 = 0;
    
    for(x = 0; x < dim; x++) {
        if (grille[x][dim-x-1] == '0') {
            resDiagonale0+=1;
        }
        else if (grille[x][dim-x-1] == 'X') {
            resDiagonaleX+=1;
        }
    }
    if (resDiagonaleX == dim) {
        return 1;
    }
    else if (resDiagonale0 == dim) {
        return 2;
    }
    resDiagonale0 = 0;
    resDiagonaleX = 0;

    return 0;
}


int testVictoire(char **grille, int dim) {

    int victoireLigne, victoireColonne, victoireDiagoGauche, victoireDiagoDroite;

    victoireLigne = testVictoireLigne(grille, dim);
    victoireColonne = testVictoireColonne(grille, dim);
    victoireDiagoGauche = testVictoireDiagoGauche(grille, dim);
    victoireDiagoDroite = testVictoireDiagoDroite(grille, dim);

    if (victoireLigne == 1 || victoireColonne == 1 || victoireDiagoGauche == 1 || victoireDiagoDroite == 1) {
        printf("Joueur 1 à gagné\n");
        return 1;
    }
    else if (victoireLigne == 2 || victoireColonne == 2 || victoireDiagoGauche == 2 || victoireDiagoDroite == 2) {
        printf("Joueur 2 à gagné\n");
        return 1;
    }
    else {
        return 0;
    }
}


int main() {
 
    int dim, x, y, xg, yg;
    int res = 0, coups = 0;
 
    //dimension de la grille
    do {
        printf("Entrez 3 -> grille 3x3\nEntrez 5 -> grille 5x5\nQuelle taille voulez vous :\n");
        scanf("%d", &dim);
    } while (dim != 3 && dim != 5);

    //création du tableau
    char** grille = malloc(dim*sizeof(char *));
    for(xg = 0; xg < dim; xg++) {
        grille[xg] = malloc(dim*sizeof(char));
        for(yg =0; yg < dim; yg++) {
            grille[xg][yg] = ' ';
        }
    }

    //affichage grille
    afficheGrille(grille, dim);

    while (res != 1 && coups != (dim * dim)) {
        //tour de joueur 1 (X)
        do {
            printf("Au joueur 1 de jouer, donnez un x & un y entre 0 et %d:\n", dim-1);
            scanf("%d%d", &x,&y);
        } while ((x < 0 || x > dim - 1) || (y < 0 || y > dim - 1) || (grille[x][y] != ' '));

        //place un 'X'
        grille[x][y] = 'X';
    
        //affichage grille
        afficheGrille(grille, dim);

        //test si victoire
        res = testVictoire(grille, dim);

        //addition d'un coup
        coups+=1;
        
        //tour de joueur 2 (0)
        if (res != 1 && coups != (dim * dim)) {
            do {
                printf("Au joueur 2 de jouer, donnez un x & un y entre 0 et 2:\n");
                scanf("%d%d", &x,&y);
            } while ((x < 0 || x > dim - 1) || (y < 0 || y > dim - 1) || (grille[x][y] != ' '));
            
            //place un '0'
            grille[x][y] = '0';    
    
            //affichage grille
            afficheGrille(grille, dim);

            //test si gagné
            res = testVictoire(grille, dim);

            //addition d'un coup
            coups+=1;
        }
    }
    
    //XO -> match nul
    if (coups == (dim * dim)) {
        printf("XO -> match nul\n");
    }
}