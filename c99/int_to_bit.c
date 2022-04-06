#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// data and printing routines for displaying bits nicely
typedef struct {
  int nbits;
  int nclusters;
  int clusters[32];
} bitspec_t;

extern bitspec_t dispspec;
extern bitspec_t statspec;

char *bitstr(int x, bitspec_t *spec);
char *bitstr_index(bitspec_t *spec);

void print_thermo_display();
// Show the thermometer display as ACII on the screen

// Generate a string version of the bits which clusters the bits based
// on the logical groupings in the problem
char *bitstr(int x, bitspec_t *spec){
  static char buffer[512];
  int idx = 0;
  int clust_idx = 0;
  int clust_break = spec->clusters[0];
  int max = spec->nbits-1;
  for(int i=0; i<spec->nbits; i++){
    if(i==clust_break){
      buffer[idx] = ' ';
      idx++;
      clust_idx++;
      clust_break += spec->clusters[clust_idx];
    }
    buffer[idx] = x & (1 << (max-i)) ? '1' : '0';
    idx++;
  }
  buffer[idx] = '\0';
  return buffer;
}

// Creates a string of bit indices matching the clustering pattern
// above
char *bitstr_index(bitspec_t *spec){
  static char buffer[512];
  char format[256];
  int pos = 0;
  int idx = spec->nbits;
  for(int i=0; i<spec->nclusters; i++){
    idx -= spec->clusters[i];
    if(spec->clusters[i] > 1){
      sprintf(format, "%s%dd ","%",spec->clusters[i]);
      pos += sprintf(buffer+pos, format, idx);
    }
    else{                       // cluster of 1 bit gets no index
      pos += sprintf(buffer+pos, "  ");
    }
  }
  buffer[pos-1] = '\0';         // eliminate trailing space
  return buffer;
}

bitspec_t dispspec = {
  .nbits = 32,
  .nclusters = 6,
  .clusters = {2, 2, 7, 7, 7, 7},
};

bitspec_t statspec = {
  .nbits = 8,
  .nclusters = 2,
  .clusters = {4,4},
};


void main(){
  int a = 123;
  int b = 123345;
  printf("a %d %s\n", a, bitstr(a, &dispspec));
  printf("bits:  %s\n",bitstr(a, &dispspec));
  printf("index: %s\n",bitstr_index(&dispspec));
  printf("bits:  %s\n",bitstr(b, &dispspec));
  printf("index: %s\n",bitstr_index(&dispspec));
}