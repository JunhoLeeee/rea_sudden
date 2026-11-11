# 웨어하우스 원본 DTX mip 복원

원본을 실행하거나 이미지를 재샘플링하지 않고, 이미 MD5 검증해 추출한 DTX의 저장된 mip 레벨을 모두 읽었다.
입력은 `previews/warehouse-textures/textures-map.json`, 출력은
`previews/warehouse-texture-mips/mips-map.json` 및 그 아래 PNG다. 기존 원본·mip0 PNG·기존 텍스처 manifest는 수정하지 않았다.

## 범위와 결과

| 항목 | 검증 결과 |
|---|---:|
| 원본 DTX | 75 |
| 원본에 저장된 mip PNG | 284 |
| 생성/보간한 mip | 0 |
| 기존 mip0 PNG와 바이트 동일 | 75 |
| 원본 DTX 합계 | 9,115,924 bytes |
| 출력 PNG 합계 | 4,390,262 bytes |

저장 mip 개수 분포는 1레벨 15개, 2레벨 1개, 3레벨 5개, 4레벨 18개, 5레벨 36개다.
75개 모두 원본 크기를 1×1까지 줄인 완전 사슬보다 짧다. 없는 꼬리 레벨을 임의로 만들지 않았다.

기존 decoder의 v-5/unsectioned BGRA8·BC1·BC2·BC3 제한은 그대로다. 헤더 크기 164 뒤부터 각 mip의
크기를 합산하며, raw는 `w*h*4`, BC는 `ceil(w/4)*ceil(h/4)*blockBytes`를 사용한다.
폭·높이는 다음 레벨에서 각각 `max(1, base >> level)`이다. 선택하지 않은 레벨도 포함해
전체 원본 크기가 정확히 맞는지 검사한 후 선택 범위만 디코드한다.

`tools/dtx_preview.py`는 `mip_layout(blob)`과 `decode(blob, mip_level=0)` /
`convert(blob, mip_level=0)`를 제공한다. 생략한 기존 호출은 기존 mip0 동작과 PNG를 유지한다.
CLI의 `--mip-level N`도 저장된 범위 밖이면 명시적으로 실패한다.

## manifest와 원본 정체성

각 `textures[]` 항목은 다음을 보존한다.

- `key`: 원본 참조를 슬래시/소문자로 정규화한 검색 키.
- `reference`, `aliases`, `package`, `member`, `source_dtx`: 원본 참조와 추출 출처.
- `source_sha256`, `source_md5`, `expected_md5`, `md5_verified`: 읽은 원본 파일과 패키지 레코드의 정체성.
- `base_width`, `base_height`, `dtx_format`, `mip_count`, `max_stored_level`, `partial_native_chain`.
- `levels[]`: `level`, `width`, `height`, `source_offset`, `source_bytes`, `source_payload_sha256`,
  프로젝트 상대 `png` 경로, 출력 폴더 상대 `png_relative`, `png_sha256`.

출력 전 모든 원본 SHA-256·MD5·크기/헤더 정보를 다시 검증했다. 저장 범위는 각 파일에서 164부터
빈틈 없이 연속이며 마지막 레벨의 끝은 정확히 원본 EOF다. 독립 PNG decoder인 Pillow로
284개를 다시 열어 RGBA 형식·레벨별 크기와 PNG SHA를 확인했다.
기록은 `evidence/warehouse-native-mip-validation.json`에 있다. 이 기록은 일반 파일 관찰이며 REA Evidence는 아니다.

## 렌더러 연결의 경계

WebGL2에서 각 원본 레벨을 그 번호에 업로드하고 `TEXTURE_MAX_LEVEL=max_stored_level`로 범위를 제한할 수 있다.
OpenGL ES 3.0의 mip 완전성은 base부터 `q=min(p,levelmax)`까지를 대상으로 하므로,
원본에 없는 1×1 꼬리를 생성할 필요가 없다. 이는 API의 완전성 규칙이며 원본 서든어택의 sampler/filter 상태를 확정한 것은 아니다.
근거는 [Khronos OpenGL ES 3.0.6 명세 §3.8.10.4와 §3.8.13](https://registry.khronos.org/OpenGL/specs/es/3.0/es_spec_3.0.pdf)다.

BC 압축 수식은 기존 decoder에 사용한
[Microsoft 블록 압축 명세](https://learn.microsoft.com/en-us/windows/win32/direct3d10/d3d10-graphics-programming-guide-resources-block-compression)를 따른다.
게임 쪽 색 공간·채널 소비·UV 방향·원래 min/mag 필터 선택과 최종 픽셀 일치는 별도 검증 대상이다.

## 재현과 검사

```powershell
python -m unittest discover -s tools -p test_dtx.py -v
python -m unittest discover -s tools -p test_export_warehouse_mips.py -v
python tools/export_warehouse_mips.py --output previews/warehouse-texture-mips-new
python tools/validate_warehouse_mips.py
```

기존 출력이 있으면 exporter는 교체하지 않고 거부한다. decoder 8개와 exporter 3개 검사에서
raw/BC1/BC3의 레벨 경계, 4보다 작은 BC 레벨, 부분 블록, 선택하지 않은 꼬리의 손상,
잘못된 selector, 원본 hash 변경, 기존 mip0 정체성 변경을 확인했다.
