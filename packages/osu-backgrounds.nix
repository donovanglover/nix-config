{ stdenvNoCC
, fetchurl
, unar
}:

stdenvNoCC.mkDerivation {
  pname = "osu-backgrounds";
  version = "2023-07-27";

  srcs = [
    (fetchurl {
      name = "2022-05-08 A Place To Belong Fanart Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/142/APTB2022-Finalists.zip";
      hash = "sha256-H1dBp4gqbN+aeEo9MhYE5mlvnPwc/mitXI/xI2wwG90=";
    })

    (fetchurl {
      name = "2022-09-15 15th Anniversary Art Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/153/winners/osu15anniversaryfinalists.zip";
      hash = "sha256-Ye5Bqr5LoM4ZQJ4NMvseR+RQtL2+H4tqW9wNpR6PISw=";
    })

    (fetchurl {
      name = "2023-05-01 Journey into a Beatmap World Art Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/175/JIBW2023-Winners.zip";
      hash = "sha256-/cQz5nCH1y42koaRldtNaekVOPENXDLJ51HVzMYKhFY=";
    })

    (fetchurl {
      name = "2022-10-29 Halloween 2022 Fanart Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/154/winners/Halloween2022FanartFinalists.zip";
      hash = "sha256-7QHg7KPr6g6ntXkfgFDZI+vxbMyYnVpUcG+iq/c9wwk=";
    })

    (fetchurl {
      name = "2017-07-11 Mocha in Summer Fanart Contest All Entries.zip";
      url = "https://assets.ppy.sh/contests/48/MochaFanartEntries.zip";
      hash = "sha256-IJrUh19IT+dvgfd2/7CuFB3OcnqZuwp1mBDDAhkSgbU=";
    })

    (fetchurl {
      name = "2021-08-23 Summer 2021 Track and Field Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/133/winners/Summer2021TFWinners.zip";
      hash = "sha256-/KbK/BpJY+GIoVRLXghDMRoQfBfR978QMk/gkd1DnZM=";
    })

    (fetchurl {
      name = "2021-10-27 Halloween 2021 Fanart Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/135/winners/Halloween2021FanartFinalists.zip";
      hash = "sha256-FUfct24QJi9UzWqqYt0jL8wCJePr3DhT6D2j8lCbe3U=";
    })

    (fetchurl {
      name = "2021-12-17 Winter 2021 Fanart Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/136/winners/Winter2021FanartContestFinalists.zip";
      hash = "sha256-Ai+06/C0ETa5Dl9XKnvL0kqdMjkvErSIxowC9vZp3x4=";
    })

    (fetchurl {
      name = "2019-12-10 Winter 2019 Fanart Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/82/osu!Winter2019HQ.zip";
      hash = "sha256-vPJ/lXrcO93+TRCkdxYuIzUXzXNoutqfzSSTkNnROmA=";
    })

    (fetchurl {
      name = "2019-10-30 Halloween 2019 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/81/winners/Halloween2019FanartWinners.zip";
      hash = "sha256-n6oVvv6oVTXhQ1Xo6MQOwdYNb0s8WBQvz/dBG5uqkJg=";
    })

    (fetchurl {
      name = "2020-12-02 Winter Sports 2020 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/114/winners/WinterSports2020Winners.zip";
      hash = "sha256-sa0J41XaserkhFspc4IDBUcxN59INIE2y086Ke9N0IM=";
    })

    (fetchurl {
      name = "2021-05-20 Spring 2021 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/125/winners/SpringFanart2021-Winners.zip";
      hash = "sha256-vbHoCErTpD8nF1YpT2f1k6Mt1Rb7bN6Oy7FeIIyVN48=";
    })

    (fetchurl {
      name = "2020-10-11 Halloween 2020 Fanart Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/112/Halloween2020Finalists.zip";
      hash = "sha256-1YV6SbjjhxuX1gaHU/8FNXX4TYjyEto8mAxTc6B7tJE=";
    })

    (fetchurl {
      name = "2020-07-23 Summer Theme Park 2020 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/107/winners/winners.zip";
      hash = "sha256-iUUyf8naBUtD6KHMN4uRZ5EzeMTR26yCzRv4j7WY0Eg=";
    })

    (fetchurl {
      name = "2020-04-24 Spring Indoors 2020 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/92/winners/winners.zip";
      hash = "sha256-wMCKtxrYBvv8QNeF7Bs8a77ko1Pphp/wouCVCExy2oc=";
    })

    (fetchurl {
      name = "2019-08-08 Summer 2019 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/79/SummerFanart2019Winners.zip";
      hash = "sha256-uJcOf9Dn+J0Gtx4Rgbkz2AeJL/1jmJBeCDN9bi+lmQw=";
    })

    (fetchurl {
      name = "2019-06-03 Spring 2019 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/78/winners/Spring2019-Winners.zip";
      hash = "sha256-6SCUR/JgrPBzmyfYlRe0KEuK3sDR+jO4BBKnrQT2sbY=";
    })

    (fetchurl {
      name = "2018-05-02 Spring 2018 Fanart Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/64/winners/osu%21%20Spring%20Fanart%202018%20Winners.zip";
      hash = "sha256-qtGuXVRYVUEbrHxhK7vJPqO1DyhtsGtmi+9qB6H7wi4=";
    })

    (fetchurl {
      name = "2023-07-27 Beach Episode Art Contest Winners.zip";
      url = "https://assets.ppy.sh/contests/179/winners/BeachEpisode2023Winners.zip";
      hash = "sha256-c/f+vZ+CmGf+Ov+mpMkuN7ICXCmNFnLfS/9RZLU18s0=";
    })

    (fetchurl {
      name = "2022-12-31 New Beginnings Art Contest Finalists.zip";
      url = "https://assets.ppy.sh/contests/160/NewBeginningsFinalists.zip";
      hash = "sha256-EnYcB0izBdJd6u1yrBf39yyUq90I0HvtVTY9K3cwtr0=";
    })

    (fetchurl {
      name = "2018-12-12 Winter 2018 Fanart Contest Winners.zip";
      url = "https://files.catbox.moe/0iv4ib.zip";
      hash = "sha256-GYfZ7yjRFDV2gWEsKyFakXL/NRtD1KogKg1yf+3Q3/Q=";
    })

    (fetchurl {
      name = "2017-04-27 Spring 2017 Fanart Contest Winners.zip";
      url = "https://files.catbox.moe/nzn2d3.zip";
      hash = "sha256-1tNiBjOs4aO+UTE5FMEbPSl2p2/qMQMrbr1XONiNelQ=";
    })

    (fetchurl {
      name = "2018-10-23 Halloween 2018 Fanart Contest Winners.zip";
      url = "https://files.catbox.moe/0ibq8k.zip";
      hash = "sha256-pMRacfvfL8zy9mNAj8F3VMuPKBUPi8g2ckYyK+rWpsM=";
    })

    (fetchurl {
      name = "2018-08-09 Summer 2018 Fanart Contest Winners.zip";
      url = "https://files.catbox.moe/sy7yuq.zip";
      hash = "sha256-TYupEImxY2EoIgXj4igw7m5S509KCl5dnE216fZ2QF0=";
    })
  ];

  nativeBuildInputs = [ unar ];

  unpackPhase = /* bash */ ''
    runHook preUnpack

    for _src in $srcs; do
      cp "$_src" $(stripHash "$_src")
      unar $(stripHash "$_src")
    done

    runHook postUnpack
  '';

  #
  installPhase = /* bash */ ''
    runHook preInstall

    mkdir -p $out/share/backgrounds
    cp -r */ $out/share/backgrounds

    runHook postInstall
  '';

  meta = {
    homepage = "https://osu.ppy.sh/home/news";
    description = "A collection of osu! fanart entries since 2017";
  };
}
