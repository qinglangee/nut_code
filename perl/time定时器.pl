$seconds = 60*60*2+60*20+5;
$step = 60;
while(1){
    print "��ʣ".(int($seconds/3600)%3600)."Сʱ".(int($seconds/60)%60)."��\n";
    sleep($step);
    $seconds -= $step;
    last if $seconds <= 0;
}
#system("d:\\movies\\donghua\\040.rmvb");
system("d:\\Document\\My Dropbox\\document\\ahk\\lock_screen_appinn_1.4\\lock.exe");

#system('..\AHK\alert.ahk');
