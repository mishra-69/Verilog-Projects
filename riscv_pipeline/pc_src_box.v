module PC_Src_Box(BA,Branch,Jump,PCSrc);
    input BA,Branch,Jump;
    output PCSrc;

    assign PCSrc=(BA&Branch)|Jump;

endmodule