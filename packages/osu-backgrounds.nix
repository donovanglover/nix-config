{ lib
, stdenvNoCC
, fetchzip
}:

stdenvNoCC.mkDerivation {
  pname = "osu-backgrounds";
  version = "2024-03-30";

  srcs = [
    (fetchzip {
      name = "2017-04-27 Spring 2017 Fanart Contest Winners";
      url = "https://files.catbox.moe/nzn2d3.zip";
      hash = "sha256-ZiX1L5umRt9NSVT1r1XojDBpdwAcHcizWyi5Yjph2Ho=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2017-07-11 Mocha in Summer Fanart Contest All Entries";
      url = "https://assets.ppy.sh/contests/48/MochaFanartEntries.zip";
      hash = "sha256-T6JIXcl30AnWOu5Z/ZMmaXh9b9XnTLSXu+H5AbI2g2M=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2018-05-02 Spring 2018 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/64/winners/osu%21%20Spring%20Fanart%202018%20Winners.zip";
      hash = "sha256-JWpQMV5E4QfrRODsRH0GXy2C0eS/PpZvG2pCKQSwwug=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2018-08-09 Summer 2018 Fanart Contest Winners";
      url = "https://files.catbox.moe/sy7yuq.zip";
      hash = "sha256-9UDH45ILPKEA9kWrHrI3eabG6STJ8QZBdJeul/aCLpA=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2018-10-23 Halloween 2018 Fanart Contest Winners";
      url = "https://files.catbox.moe/0ibq8k.zip";
      hash = "sha256-lIXHZZaUyaWF3Ebna40P2UmNMym+MB8Pxp1O2OCexs4=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2018-12-12 Winter 2018 Fanart Contest Winners";
      url = "https://files.catbox.moe/0iv4ib.zip";
      hash = "sha256-kfaXNOM+o+1/CAPLdiRX+E8HncIUA4U1rUbTdEJ18lE=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2019-06-03 Spring 2019 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/78/winners/Spring2019-Winners.zip";
      hash = "sha256-Bz4G+p3kXTpooFEu9/6+2MehkYsNeYCXyLAvKEXgIAQ=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2019-08-08 Summer 2019 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/79/SummerFanart2019Winners.zip";
      hash = "sha256-QYJCATVqirzVJQV8B7WO/0rWsKQwvqCgUbP6cIqc4SU=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2019-10-30 Halloween 2019 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/81/winners/Halloween2019FanartWinners.zip";
      hash = "sha256-O5LVrDuY47viLkdxmg0GVMVDp6nHs8EHjx1qsNayRKI=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2019-12-10 Winter 2019 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/82/osu!Winter2019HQ.zip";
      hash = "sha256-0WlRiZk81bnvYhkcPJTNBljLkkI3tMNDHF6nZ6nXuXE=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2020-04-24 Spring Indoors 2020 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/92/winners/winners.zip";
      hash = "sha256-uJjkb+M8GFDGyPqA/hhDKnjixKAaa/njW+6rGgq6Tg0=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2020-07-23 Summer Theme Park 2020 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/107/winners/winners.zip";
      hash = "sha256-cY31joP8rTRNxx8lfx4qVmIuoy71TwMSNXystmkPGpA=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2020-10-11 Halloween 2020 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/112/Halloween2020Finalists.zip";
      hash = "sha256-oUYdw+lzTosSDeyW0jenfaURvf0AlA0SxQyq3uXgZh4=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2020-12-02 Winter Sports 2020 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/114/winners/WinterSports2020Winners.zip";
      hash = "sha256-vIe3Bj4GVpPBNSxJeoRPXtgKxC7Eh7Rl0m4SGCp95zk=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2021-05-20 Spring 2021 Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/125/winners/SpringFanart2021-Winners.zip";
      hash = "sha256-EGpHIID4ZnKoH2SnwAXNKiHE4JT9KrG6hwKGTuos+X8=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2021-08-23 Summer 2021 Track and Field Fanart Contest Winners";
      url = "https://assets.ppy.sh/contests/133/winners/Summer2021TFWinners.zip";
      hash = "sha256-P/N2Kycb3CJNbm4KzXXkRdNnExaKPAFSG+UG/cG9sSQ=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2021-10-27 Halloween 2021 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/135/winners/Halloween2021FanartFinalists.zip";
      hash = "sha256-HwxT5dpG7ljtfJcAxKm+VfYLwjxhfbqHvq9MC57SVds=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2021-12-17 Winter 2021 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/136/winners/Winter2021FanartContestFinalists.zip";
      hash = "sha256-BnOIgNXVaDQsn/B7v+1HJwYKQGNiVjxue8g9C8zFGYM=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2022-05-08 A Place To Belong Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/142/APTB2022-Finalists.zip";
      hash = "sha256-o0mPxETcjHzY60hTX+M+hIssTh+xF0rXy2iYpZoF/HE=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2022-09-15 15th Anniversary Art Contest Finalists";
      url = "https://assets.ppy.sh/contests/153/winners/osu15anniversaryfinalists.zip";
      hash = "sha256-ffO8LFSSLL6mf+dqau0M14/Ikv/ZEgpYvk8zmUauVKU=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2022-10-29 Halloween 2022 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/154/winners/Halloween2022FanartFinalists.zip";
      hash = "sha256-XYIGoobZoVOcWW4l3acH7ZzLojLzM13WUi0iH+/1enM=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2022-12-31 New Beginnings Art Contest Finalists";
      url = "https://assets.ppy.sh/contests/160/NewBeginningsFinalists.zip";
      hash = "sha256-U3iGUFDuS1B27Mgf6rqqh9hl/qwJw2yVxjxh5PrTGdA=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2023-05-01 Journey into a Beatmap World Art Contest Winners";
      url = "https://assets.ppy.sh/contests/175/JIBW2023-Winners.zip";
      hash = "sha256-zOolYDj5IPm0Qrv3EbCd36ScJPOG9nTvHkxrQDTZlsw=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2023-07-27 Beach Episode Art Contest Winners";
      url = "https://assets.ppy.sh/contests/179/winners/BeachEpisode2023Winners.zip";
      hash = "sha256-2o+hGjr4h3Upg7NBj1pQ4GI3D771tj1Xgk+o2Lv29as=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2023-10-22 Halloween 2023 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/186/Halloween2023Finalists.zip";
      hash = "sha256-hRBhRKZ5hMzviNVnH9BhVU1LDazt5W0ljpvszWwungE=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2023-12-07 Winter 2023 Fanart Contest Finalists";
      url = "https://assets.ppy.sh/contests/189/WinterFanart2023Finalists.zip";
      hash = "sha256-tcK51nqncNWHiIng1WEJWCQS/F/SQQB12uj5HGd9kmE=";
      stripRoot = false;
    })

    (fetchzip {
      name = "2024-03-30 Spring 2024 Fanart Contest All Entries";
      url = "https://assets.ppy.sh/contests/205/Spring2024FanartSubmissions.zip";
      hash = "sha256-xGAj45J6F4V8E0BdI0w6xdfxmbQVH9nGwyvCusTWkUg=";
      stripRoot = false;
    })
  ];

  sourceRoot = ".";

  installPhase = /* bash */ ''
    runHook preInstall

    BASE="2024-03-30-Spring-2024-Fanart-Contest-All-Entries"
    DIR="Spring2024FanartSubmissions"

    mv $BASE/$DIR . && rm -r $BASE && mv $DIR $BASE

    mkdir -p $out
    cp -r */ $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "A collection of osu! fanart entries since 2017";
    homepage = "https://osu.ppy.sh/home/news";
    maintainers = with maintainers; [ donovanglover ];
    platforms = platforms.all;
  };
}
