<!-- 排序 -->
<view class="nav-sort oh">
  <view class="nav-sort-content">
    <block qq:for="{{search_nav_sort_list}}" qq:key="key">
      <view class="item tc fl" data-index="{{index}}" bindtap="nav_sort_event">
        <text class="cr-666">{{item.name}}</text>
        <image qq:if="{{(item.icon || null) != null}}" class="icon" src="/images/search-{{item.icon}}-icon.png" mode="aspectFill" />
      </view>
    </block>
  </view>
  <image class="screening-submit" src="/images/search-submit-icon.png" mode="aspectFill" bindtap="popup_form_event_show" />
</view>

<!-- 列表 -->
<scroll-view scroll-y="{{true}}" class="scroll-box" bindscrolltolower="scroll_lower" lower-threshold="30">
  <view class="data-list">
    <view class="items bg-white" qq:for="{{data_list}}">
      <navigator url="/pages/goods-detail/goods-detail?goods_id={{item.id}}" hover-class="none">
        <image src="{{item.images}}" mode="aspectFit" />
        <view class="base">
          <view class="multi-text">{{item.title}}</view>
          <view class="price">
            <text class="sales-price">{{currency_symbol}}{{item.min_price}}</text>
          </view>
        </view>
      </navigator>
    </view>
  </view>
  
  <view qq:if="{{data_list.length == 0}}">
    <import src="/pages/common/nodata.qml" />
    <template is="nodata" data="{{status: data_list_loding_status}}"></template>
  </view>
    
  <import src="/pages/common/bottom_line.qml" />
  <template is="bottom_line" data="{{status: data_bottom_line_status}}"></template>
</scroll-view>

<!-- 筛选条件 popup -->
<component-popup prop-show="{{is_show_popup_form}}" prop-position="left" bindonclose="popup_form_event_close">
  <form bindsubmit="form_submit_event" class="popup-form oh bg-white">
    <view class="search-map">
      <view class="map-item map-base">
        <text>筛选出</text>
        <text class="cr-main"> {{data_total}} </text>
        <text>条数据</text>
        <text class="map-remove-submit fr" bindtap="map_remove_event">清除</text>
      </view>

      <!-- 搜索关键字 -->
      <input type="text" placeholder="其实搜索很简单^_^ !" name="wd" value="{{(post_data.wd || '')}}" class="map-keywords wh-auto" placeholder-class="cr-ccc" />

      <!-- 品牌 -->
      <view qq:if="{{((brand_list || null) != null && brand_list.length > 0) || ((search_map_info.brand || null) != null)}}" class="map-item">
        <view class="map-nav tc">
          <text>品牌</text>
          <text class="arrow-bottom" qq:if="{{brand_list.length > 3}}" bindtap="more_event" data-value="brand_list">更多</text>
        </view>
        <view qq:if="{{(search_map_info.brand || null) != null}}" class="map-content brand-info oh bg-white">
          <image qq:if="{{(search_map_info.brand.logo || null) != null}}" src="{{search_map_info.brand.logo}}" mode="aspectFit" class="fl" />
          <view qq:else class="info-logo-empty tc fl">{{search_map_info.brand.name}}</view>
          <view class="info-right fr">
            <view qq:if="{{(search_map_info.brand.logo || null) != null}}" class="info-name">{{search_map_info.brand.name}}</view>
            <view qq:if="{{(search_map_info.brand.describe || null) != null}}"class="info-desc multi-text">{{search_map_info.brand.describe}}</view>
          </view>
        </view>
        <view qq:else class="map-content map-images-text-items map-brand-container oh bg-white" style="height:{{map_fields_list.brand_list.height}};">
          <block qq:for="{{brand_list}}" qq:key="key">
            <view class="fl tc single-text {{item.active == 1 ? 'active' : ''}}" bindtap="map_item_event" data-index="{{index}}" data-field="brand_list">
              <image qq:if="{{(item.logo || null) != null}}" src="{{item.logo}}" mode="aspectFit" />
              <text qq:else>{{item.name}}</text>
            </view>
          </block>
        </view>
      </view>

      <!-- 分类 -->
      <view qq:if="{{(category_list || null) != null && category_list.length > 0}}" class="map-item">
        <view class="map-nav tc">
          <text>分类</text>
          <text class="arrow-bottom" qq:if="{{category_list.length > 3}}" bindtap="more_event" data-value="category_list">更多</text>
        </view>
        <view class="map-content map-text-items map-category-container oh bg-white" style="height:{{map_fields_list.category_list.height}};">
          <block qq:for="{{category_list}}" qq:key="key">
            <view class="fl {{item.active == 1 ? 'active' : ''}}" bindtap="map_item_event" data-index="{{index}}" data-field="category_list">{{item.name}}</view>
          </block>
        </view>
      </view>

      <!-- 价格 -->
      <view qq:if="{{(screening_price_list || null) != null && screening_price_list.length > 0}}" class="map-item">
        <view class="map-nav tc">
          <text>价格</text>
          <text class="arrow-bottom" qq:if="{{screening_price_list.length > 3}}" bindtap="more_event" data-value="screening_price_list">更多</text>
        </view>
        <view class="map-content map-text-items screening-price-container oh bg-white" style="height:{{map_fields_list.screening_price_list.height}};">
          <block qq:for="{{screening_price_list}}" qq:key="key">
            <view class="fl {{item.active == 1 ? 'active' : ''}}" bindtap="map_item_event" data-index="{{index}}" data-field="screening_price_list">{{item.name}}</view>
          </block>
        </view>
      </view>

      <!-- 属性 -->
      <view qq:if="{{(goods_params_list || null) != null && goods_params_list.length > 0}}" class="map-item">
        <view class="map-nav tc">
          <text>属性</text>
          <text class="arrow-bottom" qq:if="{{goods_params_list.length > 3}}" bindtap="more_event" data-value="goods_params_list">更多</text>
        </view>
        <view class="map-content map-text-items goods-params-container oh bg-white" style="height:{{map_fields_list.goods_params_list.height}};">
          <block qq:for="{{goods_params_list}}" qq:key="key">
            <view class="fl {{item.active == 1 ? 'active' : ''}}" bindtap="map_item_event" data-index="{{index}}" data-field="goods_params_list">{{item.value}}</view>
          </block>
        </view>
      </view>

      <!-- 规格 -->
      <view qq:if="{{(goods_spec_list || null) != null && goods_spec_list.length > 0}}" class="map-item">
        <view class="map-nav tc">
          <text>规格</text>
          <text class="arrow-bottom" qq:if="{{goods_spec_list.length > 3}}" bindtap="more_event" data-value="goods_spec_list">更多</text>
        </view>
        <view class="map-content map-text-items goods-spec-container oh bg-white" style="height:{{map_fields_list.goods_spec_list.height}};">
          <block qq:for="{{goods_spec_list}}" qq:key="key">
            <view class="fl {{item.active == 1 ? 'active' : ''}}" bindtap="map_item_event" data-index="{{index}}" data-field="goods_spec_list">{{item.value}}</view>
          </block>
        </view>
      </view>

      <button formType="submit" class="bg-main search-submit wh-auto" disabled="{{popup_form_loading_status}}" hover-class="none">确认</button>
    </view>
  </form>
</component-popup>

<!-- 快捷导航 -->
<component-quick-nav></component-quick-nav>