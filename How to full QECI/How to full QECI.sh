Điều này là 1 trải nghiệm lớn nhất đời tôi khi cài full QE/CI 4600HD
Đầu tiên bạn phải hiểu bản chất khi cài full QE/CI
Ok Let go
Đầu tiên
1.  DSDT phải sửa chữa hết lỗi
    Nên nhớ : SSDT mới ảnh hưởng tới độ phân giải QE/cài
    DSDT ko ảnh hưởng
2. File AppleIntelHD5000Graphics.kext là file quan trọng để kík hoạt em yêu full.Ko có nó thì chỉ hiên 1500mb mà ko full QE/CI
3. Làm theo hướng dẫn
http://www.tonymacx86.com/yosemite-laptop-support/145427-fix-intel-hd4200-hd4400-hd4600-mobile-yosemite.html
Các bước sẽ làm sau
    1.tải cái này
    https://bitbucket.org/RehabMan/os-x-...i-id/downloads
    2. xoá file AppleIntelHD5000GraphicsAppleIntelGra,libCLVMIGILPlugin.dylib(tốt nhất nên save bản gốc vào 1 folder riêng ko xử lý mệt)
    3. Install FakePCIID_HD4600_HD4400.kext &&  FakePCIID.kext
        Chú ý : Dùng Kext Wizard ( tôi dùng thấy ok ).
        Sau đó rebuild cache với cú pháp dưới:
        sudo touch /System/Library/Extensions && sudo kextcache -u / 
        Rồi vào xem thư mục Extensions coi có file :  AppleIntelHD5000Graphics.kext 
        ko có thì làm lại các bước nha( nếu vẫn ko có thì chuyển tới bước tiếp theo)
    4.Chỉnh sửa file config.plist
        Boot : -v rootless=0 nv_disable=1(nếu có nvidia) kext-dev-mode=1
        ig-platform-id : 0x0a260006, Inject Intel , Inject EDID 
        Xem ảnh 1,2,3
        Nếu nhác bạn copy file EFI có sẵn đẩy vào EFI gốc bạn
    5. Dành cho các bạn ko có file AppleIntelHD5000Graphics 
        Chỉ còn 1 cách là update MACOS
    6. Reset và thưởng thức

Engsub
1.  DSDT make sure it's not have error. I don't care that hơw many warring. So you sould save it in EFI/Clover/ACPI/patched
    And patch 
    "into method label _DSM parent_adr 0x00020000 remove_entry;
    into device name_adr 0x00020000 insert
    begin
    Method (_DSM, 4, NotSerialized)\n
    {\n
        If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }\n
        Return (Package()\n
        {\n
            "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },\n
            "AAPL,ig-platform-id", Buffer() { 0x06, 0x00, 0x26, 0x0a },\n
            "hda-gfx", Buffer() { "onboard-1" },\n
            "model", Buffer() { "Intel HD 4600" },\n
        })\n
    }\n
    end;" 
    If not work, don't worry. Go to Step 2
2.  Remove any existing patches to AppleIntelHD5000Graphics and libCLVMIGILPlugin.dylib before taking the below steps, including kext patches through Clover.
3.  Install FakePCIID in forder ỏr link https://bitbucket.org/RehabMan/os-x-...i-id/downloads
    I not sure that you use software that you install, I prefer use Kext Wizard
    Rebuid cache by open terminal : 
    sudo touch /System/Library/Extensions && sudo kextcache -u /
    Look in /System/Library/Extensions, make sure it's AppleIntelHD5000Graphics
    If you don't have upgrade Mac Os.
    Clover without cache (boot: -f) 
4. Reset