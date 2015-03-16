#!/usr/bin/perl

sub get_camelid_data {
my %camelid_links = (
    one   => { url         => 'http://www.online.discovery.com/news/picture/may99/photo20.html',
               description => 'Bactrian Camel in front of Great Pyramids in Giza, Egypt.'},
    two   => { url         => 'http://www.fotos-online.de/english/m/09/9532.htm',
               description => 'Dromedary Camel illustrates the importance of accessorizing.'},
    three => { url         => 'http://www.eskimo.com/~wallama/funny.htm',
               description => 'Charlie - biography of a narcissistic llama.'},
    four  => { url         => 'http://arrow.colorado.edu/travels/other/turkey.html',
               description => 'A visual metaphor for the perl5-porters list?'},
    five  => { url         => 'http://www.galaonline.org/pics.htm',
               description => 'Many cool alpacas.'},
    six   => { url         => 'http://www.thpf.de/suedamerikareise/galerie/vicunas.htm',
               description => 'Wild Vicunas in a scenic landscape.'}
);

return %camelid_links;
}
1;
