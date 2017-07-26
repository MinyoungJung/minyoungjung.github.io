---
layout: post
title: RecyclerView 사용 패턴
category: [안드로이드]
tags: [Android, Java]
---

RecyclerView에서는 기본적으로 ViewHolder 패턴을 사용한다.  
ListView보다 사용하기 까다로워 보이지만 사용 패턴을 익히면 그렇지도 않다.

# RecyclerView 사용패턴

## Adapter 생성
RecyclerSwipeAdapter<RecyclerViewAdapter.ViewHolder> 를 상속한 아답터를 생성한다.  
### 생성자
``` java
public RecyclerViewAdapter(Context context, ArrayList<Data> myDataset) {
    mContext = context;
    mDataset = myDataset;
}
```
데이터와 context를 전달 받는다.

### OnCreateViewHoder 오버라이드
``` java
@Override
public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
    View v = LayoutInflater.from(parent.getContext())
    .inflate(R.layout.recyclerlayout, parent, false);
    ViewHolder vh = new ViewHolder(v);
    return vh;
}
```
위와 같이 레이아웃을 인플래이트 시킨 후 뷰 홀더에 집어넣는다.

### getItemCount 오버라이드
``` java
@Override
public int getItemCount() {
    return mDataset.size();
}
```

### ViewHolder 클래스 생성
``` java
public static class ViewHolder extends RecyclerView.ViewHolder {
    private TextView mTextView;

public ViewHolder(View v) {
    super(v);

    mTextView = v.findViewById(R.id.textview);
    }
}
```
뷰홀더 클래스의 생성자 안에서 사용할 뷰들을 바인드 한다.

### onBindViewHolder 오버라이드
@Override
public void onBindViewHolder(final ViewHolder holder, final int position) {
    final Phrase item = mDataset.get(position);

    holder.mTextView.setText(mData.get(position).toString());
    }
}
RecyclerView의 각각의 뷰가 표시될 때 처리할 내용을 작성한다.


## Adapter 설정
RecyclerView에 .setAdapter를 통해 아답터를 설정한다.




