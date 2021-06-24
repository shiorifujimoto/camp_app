if (document.URL.match( "posts/\d*" )) {
  document.addEventListener('DOMContentLoaded', function() {
    const wideImg = document.getElementById('wide-img');
    const firstImagesSrc = document.querySelector('img.post-image').src;
    // console.log(FirstPostImages);

    // 大きい画像を生成 
    const firstImage = document.createElement('img')
    firstImage.setAttribute('src', firstImagesSrc)
    firstImage.setAttribute('class', 'first-img')
    
    // 生成したHTMLの要素をブラウザに表示させる
    wideImg.appendChild(firstImage)
    
    
    //投稿画像の情報取得
    const postImages = document.querySelectorAll('img.post-image');
    
    // 投稿画像が一つなら大きい画像のみ表示
    if (postImages.length == 1) {
      // 小さい画像非表示
      const none = document.getElementById('child-img');
      none.style.display = "none";
    } else {
    // 1つずつに対してイベント
      postImages.forEach(img => 
        img.addEventListener('click', (e) => {
          const nextImageSrc = img.src
          // 選択した画像の表示切り替え
          const nextImage = document.createElement('img')
          firstImage.setAttribute('src', nextImageSrc)
          firstImage.setAttribute('class', 'next-img')
        })
      )
    }
  });
}